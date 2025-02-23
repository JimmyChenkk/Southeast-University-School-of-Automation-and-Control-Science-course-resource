import sys
sys.stdout.reconfigure(encoding='utf-8')
import numpy as np
import matplotlib.pyplot as plt
def move(s, direction):
    x, y = s
    if direction == 0 and x + 1 < nrows and (x + 1, y) != (1, 1):
        return (x + 1, y)
    if direction == 1 and y - 1 >= 0 and (x, y - 1) != (1, 1):
        return (x, y - 1)
    if direction == 2 and y + 1 < ncolumns and (x, y + 1) != (1, 1):
        return (x, y + 1)
    if direction == 3 and x - 1 >= 0 and (x - 1, y) != (1, 1):
        return (x - 1, y)
    return s
def calculate_transition_probabilities(s, action):
    P = np.zeros((nrows, ncolumns))
    directions = [0, 1, 2, 3]
    main_dir = directions[action]
    side_dirs = [directions[(action + 1) % 4], directions[(action + 3) % 4]]
    P[move(s, main_dir)] += 0.8
    P[move(s, side_dirs[0])] += 0.1
    P[move(s, side_dirs[1])] += 0.1
    return P
def calculate_best_action_and_utility(s, U):
    utilities = []
    for action in actions:
        P = calculate_transition_probabilities(s, action)
        expected_utility = np.sum(P * U)
        utilities.append(expected_utility)
    best_action = np.argmax(utilities)
    return best_action, max(utilities)
def value_iteration():
    U = np.zeros((nrows, ncolumns))
    while True:
        delta = 0
        U_new = np.copy(U)
        for s in states:
            if s in terminals:
                U_new[s] = rewards[s]
                continue
            _, max_utility = calculate_best_action_and_utility(s, U)
            U_new[s] = rewards[s] + gamma * max_utility
            delta = max(delta, abs(U_new[s] - U[s]))
        if delta < max_error * (1 - gamma) / gamma:
            break
        U = U_new
    return U
def policy_evaluation(Pi):
    U = np.zeros((nrows, ncolumns))
    while True:
        delta = 0
        U_new = np.copy(U)
        for s in states:
            if s in terminals:
                U_new[s] = rewards[s]
                continue
            action = Pi[s]
            P = calculate_transition_probabilities(s, action)
            U_new[s] = rewards[s] + gamma * np.sum(P * U)
            delta = max(delta, abs(U_new[s] - U[s]))
        if delta < max_error:
            break
        U = U_new
    return U
def policy_iteration():
    Pi = np.random.choice(actions, size=(nrows, ncolumns))
    while True:
        U = policy_evaluation(Pi)
        policy_stable = True
        for s in states:
            best_action, _ = calculate_best_action_and_utility(s, U)
            if Pi[s] != best_action:
                Pi[s] = best_action
                policy_stable = False
        if policy_stable:
            break
    return Pi
def plot_policy(Pi, title):
    fig, ax = plt.subplots()
    ax.set_xlim(0, ncolumns)
    ax.set_ylim(0, nrows)
    ax.set_xticks(np.arange(ncolumns))
    ax.set_yticks(np.arange(nrows))
    ax.grid(True)
    for x in range(nrows):
        for y in range(ncolumns):
            s = (x, y)
            if s == (1, 1):
                ax.text(y + 0.5, nrows - 1 - x + 0.5, 'X', fontsize=24, ha='center', va='center', color='red')
            elif s in terminals:
                ax.text(y + 0.5, nrows - 1 - x + 0.5, str(rewards[s]), fontsize=24, ha='center', va='center')
            else:
                a = Pi[s]
                arrow = ["↓", "←", "→", "↑"][a]
                ax.text(y + 0.5, nrows - 1 - x + 0.5, arrow, fontsize=24, ha='center', va='center')
    ax.set_title(title)
    plt.show()
nrows, ncolumns = 3, 4
states = [(i, j) for i in range(nrows) for j in range(ncolumns) if (i, j) != (1, 1)]
terminals = [(1, 3), (2, 3)]
actions = (0, 1, 2, 3)
rewards = [0.01, -0.01, -0.04]
for reward in rewards:
    rewards = np.full((nrows, ncolumns), reward)
    rewards[1, 3], rewards[2, 3] = -1, 1
    gamma = 0.8
    max_error = 1e-4
    print("值迭代")
    U_value = value_iteration()
    Pi_value = np.zeros_like(U_value, dtype=int)
    for s in states:
        Pi_value[s], _ = calculate_best_action_and_utility(s, U_value)
    print("U (值迭代):")
    print(U_value)
    print("π (值迭代):")
    print(Pi_value)
    plot_policy(Pi_value, f"Value Iteration Policy (reward={reward})")
    print("策略迭代")
    Pi_policy = policy_iteration()
    U_policy = policy_evaluation(Pi_policy)
    print("U (策略迭代):")
    print(U_policy)
    print("π (策略迭代):")
    print(Pi_policy)
    plot_policy(Pi_policy, f"Policy Iteration Policy (reward={reward})")