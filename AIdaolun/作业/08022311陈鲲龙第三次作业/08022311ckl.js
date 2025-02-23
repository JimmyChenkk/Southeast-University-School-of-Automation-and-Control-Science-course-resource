let stoneCount = 10;
let gameOver = false;
let currentPlayer = '玩家';
let algorithm = '';

const output = document.getElementById('output');
const stoneCountElement = document.getElementById('stone-count');

function handleKeyPress(event) {
  if (event.key === 'Enter') {
    playerMove();
  }
}

function startGame(selectedAlgorithm) {
  stoneCount = 10;
  gameOver = false;
  currentPlayer = '玩家';
  algorithm = selectedAlgorithm;
  updateGameState();
  output.innerHTML = '游戏开始，玩家轮到您了！';
}

function updateGameState() {
  stoneCountElement.textContent = stoneCount;
  document.getElementById('player-move').value = '';
}

function playerMove() {
  if (gameOver) return;

  let move = parseInt(document.getElementById('player-move').value);
  if (isNaN(move) || move < 1 || move > 3) {
    output.innerHTML = '请输入1到3颗石子的有效数字！';
    return;
  }

  if (move > stoneCount) {
    output.innerHTML = '您不能取超过剩余石子的数量！';
    return;
  }

  stoneCount -= move;
  currentPlayer = '计算机';
  updateGameState();
  checkGameOver();

  if (!gameOver) {
    output.innerHTML = '计算机思考中...';
    computerMove();
  }
}

function computerMove() {
  let move;
  if (algorithm === 'minmax') {
    move = minMaxMove(stoneCount);
  } else if (algorithm === 'alphaBeta') {
    move = alphaBetaMove(stoneCount, -Infinity, Infinity, true);
  }

  stoneCount -= move;
  currentPlayer = '玩家';
  output.innerHTML = '计算机取了' + move + '颗石头。玩家轮到您了';
  updateGameState();
  checkGameOver();
}

function checkGameOver() {
  if (stoneCount <= 0) {
    gameOver = true;
    if (currentPlayer === '玩家') {
      output.innerHTML = '计算机获胜！';
    } else {
      output.innerHTML = '玩家获胜！';
    }
  }
}

// MinMax 算法
function minMaxMove(stones) {
  const result = minMax(stones, true);
  return result.bestMove;
}

function minMax(stones, isMaximizing) {
  if (stones <= 0) {
    return { score: isMaximizing ? -1 : 1, bestMove: 0 };
  }

  let bestScore = isMaximizing ? -Infinity : Infinity;
  let bestMove = 0;

  for (let i = 1; i <= 3; i++) {
    if (stones - i >= 0) {
      const result = minMax(stones - i, !isMaximizing);
      if ((isMaximizing && result.score > bestScore) || (!isMaximizing && result.score < bestScore)) {
        bestScore = result.score;
        bestMove = i;
      }
    }
  }

  return { score: bestScore, bestMove };
}

// α-β 剪枝算法
function alphaBetaMove(stones, alpha, beta, isMaximizing) {
  const result = alphaBeta(stones, alpha, beta, isMaximizing);
  return result.bestMove;
}

function alphaBeta(stones, alpha, beta, isMaximizing) {
  if (stones <= 0) {
    return { score: isMaximizing ? -1 : 1, bestMove: 0 };
  }

  let bestScore = isMaximizing ? -Infinity : Infinity;
  let bestMove = 0;

  for (let i = 1; i <= 3; i++) {
    if (stones - i >= 0) {
      const result = alphaBeta(stones - i, alpha, beta, !isMaximizing);
      if (isMaximizing) {
        if (result.score > bestScore) {
          bestScore = result.score;
          bestMove = i;
        }
        alpha = Math.max(alpha, bestScore);
      } else {
        if (result.score < bestScore) {
          bestScore = result.score;
          bestMove = i;
        }
        beta = Math.min(beta, bestScore);
      }
      if (beta <= alpha) {
        break;
      }
    }
  }

  return { score: bestScore, bestMove };
}