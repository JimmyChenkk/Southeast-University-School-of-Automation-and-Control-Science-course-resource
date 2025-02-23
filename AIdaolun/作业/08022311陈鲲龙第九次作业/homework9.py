import sys
sys.stdout.reconfigure(encoding='utf-8')
import numpy as np
import matplotlib.pyplot as plt
class GridWorld:
    def __init__(self, n_rows=3, n_cols=4, step_reward=-0.04):
        self.n_rows = n_rows
        self.n_cols = n_cols
        self.obstacle = (1, 1)
        self.goal_plus = (0, 3)
        self.goal_minus = (1, 3)
        self.step_reward = step_reward
        self.actions = [0, 1, 2, 3]
        self.reset()
    def reset(self):
        while True:
            row = np.random.randint(self.n_rows)
            col = np.random.randint(self.n_cols)
            if (row, col) != self.obstacle and (row, col) != self.goal_plus and (row, col) != self.goal_minus:
                self.agent_pos = (row, col)
                break
        return self.agent_pos
    def step(self, action):
        row, col = self.agent_pos
        if (row, col) in [self.goal_plus, self.goal_minus]:
            return (row, col), 0.0, True
        new_row, new_col = row, col
        if action == 0: new_row, new_col = row - 1, col
        elif action == 1: new_row, new_col = row, col + 1
        elif action == 2: new_row, new_col = row + 1, col
        elif action == 3: new_row, new_col = row, col - 1
        if new_row < 0 or new_row >= self.n_rows or new_col < 0 or new_col >= self.n_cols or (new_row, new_col) == self.obstacle:
            new_row, new_col = row, col
        self.agent_pos = (new_row, new_col)
        if (new_row, new_col) == self.goal_plus:
            return (new_row, new_col), 1.0, True
        elif (new_row, new_col) == self.goal_minus:
            return (new_row, new_col), -1.0, True
        else:
            return (new_row, new_col), self.step_reward, False
def exploratory_mc(env: GridWorld, n_episodes=5000, gamma=0.95, epsilon=0.1, max_steps=100):
    rows, cols = env.n_rows, env.n_cols
    num_actions = len(env.actions)
    Q = np.zeros((rows, cols, num_actions))
    returns_count = np.zeros_like(Q)
    returns_sum = np.zeros_like(Q)
    for _ in range(n_episodes):
        episode = []
        state = env.reset()
        done = False
        for step_i in range(max_steps):
            if done:
                break
            if np.random.rand() < epsilon:
                action = np.random.choice(num_actions)
            else:
                action = np.argmax(Q[state[0], state[1], :])
            next_state, reward, done = env.step(action)
            episode.append((state, action, reward))
            state = next_state
        G = 0.0
        visited = set()
        for t in reversed(range(len(episode))):
            state, action, reward = episode[t]
            G = gamma * G + reward
            if (state, action) not in visited:
                visited.add((state, action))
                returns_count[state[0], state[1], action] += 1
                returns_sum[state[0], state[1], action] += G
                Q[state[0], state[1], action] = returns_sum[state[0], state[1], action] / returns_count[state[0], state[1], action]
    return Q
def q_learning(env: GridWorld, n_episodes=5000, alpha=0.1, gamma=0.9, epsilon=0.1, max_steps=100):
    rows, cols = env.n_rows, env.n_cols
    num_actions = len(env.actions)
    Q = np.zeros((rows, cols, num_actions))
    for episode in range(n_episodes):
        state = env.reset()
        done = False
        for step_i in range(max_steps):
            if done:
                break
            if np.random.rand() < epsilon:
                action = np.random.choice(num_actions)
            else:  # Exploitation
                action = np.argmax(Q[state[0], state[1], :])
            next_state, reward, done = env.step(action)
            if not done:
                best_action_next = np.argmax(Q[next_state[0], next_state[1], :])
                target = reward + gamma * Q[next_state[0], next_state[1], best_action_next]
            else:
                target = reward
            td_error = target - Q[state[0], state[1], action]
            Q[state[0], state[1], action] += alpha * td_error
            state = next_state
    return Q
def extract_policy_and_value_from_q(Q):
    rows, cols, num_actions = Q.shape
    policy = np.zeros((rows, cols), dtype=int)
    value_function = np.zeros((rows, cols))
    for row in range(rows):
        for col in range(cols):
            action_values = Q[row, col, :]
            best_action = np.argmax(action_values)
            policy[row, col] = best_action
            value_function[row, col] = action_values[best_action]
    return policy, value_function
def display_value(value_function, obstacle=(1, 1), goal_plus=(0, 3), goal_minus=(1, 3)):
    rows, cols = value_function.shape
    value_grid = np.zeros((rows, cols))
    for row in range(rows):
        for col in range(cols):
            if (row, col) == obstacle:
                value_grid[row, col] = np.nan
            elif (row, col) == goal_plus or (row, col) == goal_minus:
                value_grid[row, col] = 0.0
            else:
                value_grid[row, col] = value_function[row, col]
    print(value_grid)
def display_policy(policy, obstacle=(1, 1), goal_plus=(0, 3), goal_minus=(1, 3)):
    direction_map = {0: "↑", 1: "→", 2: "↓", 3: "←"}
    rows, cols = policy.shape
    for row in range(rows):
        row_symbols = []
        for col in range(cols):
            if (row, col) == obstacle:
                row_symbols.append("□")
            elif (row, col) == goal_plus:
                row_symbols.append("+1")
            elif (row, col) == goal_minus:
                row_symbols.append("-1")
            else:
                action = policy[row, col]
                row_symbols.append(direction_map[action])
        print(row_symbols)
    print()
def plot_policy(title, policy, value_function, obstacle=(1, 1), goal_plus=(0, 3), goal_minus=(1, 3)):
    fig, ax = plt.subplots(figsize=(5, 4))
    rows, cols = policy.shape
    ax.set_xlim(-0.5, cols - 0.5)
    ax.set_ylim(-0.5, rows - 0.5)
    ax.invert_yaxis()
    for row in range(rows + 1):
        ax.plot([-0.5, cols - 0.5], [row - 0.5, row - 0.5], 'k-')
    for col in range(cols + 1):
        ax.plot([col - 0.5, col - 0.5], [-0.5, rows - 0.5], 'k-')
    direction_map = {0: "↑", 1: "→", 2: "↓", 3: "←"}
    for row in range(rows):
        for col in range(cols):
            if (row, col) == obstacle:
                ax.fill_between([col - 0.5, col + 0.5], row - 0.5, row + 0.5, color="black")
            elif (row, col) == goal_plus:
                ax.text(col, row, "+1", ha="center", va="center", fontsize=15)
            elif (row, col) == goal_minus:
                ax.text(col, row, "-1", ha="center", va="center", fontsize=15)
            else:
                ax.text(col, row, f"{direction_map[policy[row, col]]}", ha="center", va="center", fontsize=50)
    ax.set_title(title)
    plt.show()
env = GridWorld()
Q_qlearning = q_learning(env)
Q_exploratory_mc = exploratory_mc(env)
policy_qlearning, V_qlearning = extract_policy_and_value_from_q(Q_qlearning)
policy_exploratory_mc, V_exploratory_mc = extract_policy_and_value_from_q(Q_exploratory_mc)
print("Q-Learning Value Function:")
display_value(V_qlearning)
print("Q-Learning Policy:")
display_policy(policy_qlearning)
print("Exploratory MC Value Function:")
display_value(V_exploratory_mc)
print("Exploratory MC Policy:")
display_policy(policy_exploratory_mc)
plot_policy("Q-Learning Policy", policy_qlearning, V_qlearning)
plot_policy("Exploratory MC Policy", policy_exploratory_mc, V_exploratory_mc)