const romaniaMap = {
  'Arad': [['Sibiu', 140], ['Timisoara', 118], ['Zerind', 75]],
  'Zerind': [['Arad', 75], ['Oradea', 71]],
  'Oradea': [['Sibiu', 151], ['Zerind', 71]],
  'Timisoara': [['Arad', 118], ['Lugoj', 111]],
  'Lugoj': [['Mehadia', 70], ['Timisoara', 111]],
  'Mehadia': [['Drobeta', 75], ['Lugoj', 70]],
  'Drobeta': [['Craiova', 120], ['Mehadia', 75]],
  'Craiova': [['Craiova', 120], ['Pitesti', 138], ['Rimnicu Vilcea', 146]],
  'Sibiu': [['Arad', 140], ['Fagaras', 99], ['Oradea', 151], ['Rimnicu Vilcea', 80]],
  'Fagaras': [['Bucharest', 211], ['Sibiu', 99]],
  'Rimnicu Vilcea': [['Craiova', 146], ['Pitesti', 97], ['Sibiu', 80]],
  'Pitesti': [['Bucharest', 101], ['Craiova', 138], ['Rimnicu Vilcea', 97]],
  'Bucharest': [['Fagaras', 211], ['Giurgiu', 77], ['Pitesti', 101], ['Urziceni', 85]],
  'Giurgiu': [['Bucharest', 90]],
  'Urziceni': [['Bucharest', 85], ['Hirsova', 98], ['Vaslui', 142]],
  'Hirsova': [['Eforie', 86], ['Urziceni', 98]],
  'Eforie': [['Hirsova', 86]],
  'Vaslui': [['Iasi', 92], ['Urziceni', 142]],
  'Iasi': [['Neamt', 87], ['Vaslui', 92]],
  'Neamt': [['Iasi', 87]]
};
const cityPositions = {
  'Arad': [80, 100], 'Zerind': [80, 60], 'Timisoara': [70, 160],
  'Oradea': [120, 40], 'Lugoj': [130, 170], 'Mehadia': [130, 240],
  'Drobeta': [140, 300], 'Craiova': [200, 290], 'Sibiu': [150, 120],
  'Fagaras': [300, 180], 'Rimnicu Vilcea': [180, 200],
  'Pitesti': [250, 220], 'Bucharest': [400, 300],
  'Giurgiu': [380, 340], 'Urziceni': [420, 260], 'Hirsova': [480, 270],
  'Eforie': [490, 330], 'Vaslui': [480, 200], 'Iasi': [450, 170],
  'Neamt': [420, 150]
};
const straightLineDistances = {
  'Arad': 366,
  'Bucharest': 0,
  'Craiova': 160,
  'Drobeta': 242,
  'Eforie': 161,
  'Fagaras': 178,
  'Giurgiu': 77,
  'Hirsova': 151,
  'Iasi': 226,
  'Lugoj': 244,
  'Mehadia': 241,
  'Neamt': 234,
  'Oradea': 380,
  'Pitesti': 98,
  'Rimnicu Vilcea': 193,
  'Sibiu': 253,
  'Timisoara': 329,
  'Urziceni': 80,
  'Vaslui': 199,
  'Zerind': 374
};
const canvas = document.getElementById('mapCanvas');
const ctx = canvas.getContext('2d');
function drawMap() {
  for (let city in cityPositions) {
    let [x, y] = cityPositions[city];
    ctx.beginPath();
    ctx.arc(x, y, 10, 0, Math.PI * 2);
    ctx.fillStyle = 'grey';
    ctx.fill();
    ctx.stroke();
    ctx.fillText(city, x - 15, y - 15);
  }
  for (let city in romaniaMap) {
    let [x1, y1] = cityPositions[city];
    for (let [neighbor, weight] of romaniaMap[city]) {
      let [x2, y2] = cityPositions[neighbor];
      ctx.beginPath();
      ctx.moveTo(x1, y1);
      ctx.lineTo(x2, y2);
      ctx.stroke();
      let midX = (x1 + x2) / 2;
      let midY = (y1 + y2) / 2;
      ctx.fillStyle = 'red';
      ctx.fillText(weight, midX, midY - 5);
    }
  }
}
function bfsTreeSearch(start, goal) {
  let queue = [start];
  let parentMap = {};
  let visitedOrder = [];
  while (queue.length > 0) {
    let current = queue.shift();
    visitedOrder.push(current);
    if (current === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    for (let [neighbor] of romaniaMap[current]) {
      if (!parentMap[neighbor]) {
        queue.push(neighbor);
        parentMap[neighbor] = current;
      }
    }
  }
  return { path: null, visitedOrder };
}
function bfsGraphSearch(start, goal) {
  let queue = [start];
  let visited = new Set();
  let parentMap = {};
  let visitedOrder = [];
  visited.add(start);
  while (queue.length > 0) {
    let current = queue.shift();
    visitedOrder.push(current);
    if (current === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    for (let [neighbor] of romaniaMap[current]) {
      if (!visited.has(neighbor)) {
        queue.push(neighbor);
        visited.add(neighbor);
        parentMap[neighbor] = current;
      }
    }
  }
  return { path: null, visitedOrder };
}
function dfsTreeSearch(start, goal) {
  let stack = [start];
  let parentMap = {};
  let visitedOrder = [];
  while (stack.length > 0) {
    let current = stack.pop();
    if (current === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    if (!romaniaMap[current]) {
      continue;
    }
    for (let [neighbor] of romaniaMap[current]) {
      if (!parentMap[neighbor]) {
        stack.push(neighbor);
        visitedOrder.push(neighbor);
        parentMap[neighbor] = current;
      }
    }
  }
  return { path: null, visitedOrder };
}
function dfsGraphSearch(start, goal) {
  let stack = [start];
  let visited = new Set();
  let parentMap = {};
  visited.add(start);
  let visitedOrder = [];
  while (stack.length > 0) {
    let current = stack.pop();
    if (current === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    if (!romaniaMap[current]) {
      continue;
    }
    for (let [neighbor] of romaniaMap[current]) {
      if (!visited.has(neighbor)) {
        stack.push(neighbor);
        visited.add(neighbor);
        visitedOrder.push(neighbor);
        parentMap[neighbor] = current;
      }
    }
  }
  return { path: null, visitedOrder };
}
function ucsTreeSearch(start, goal) {
  let priorityQueue = [{ city: start, cost: 0 }];
  let parentMap = {};
  let costs = { [start]: 0 };
  let visitedOrder = [];
  while (priorityQueue.length > 0) {
    priorityQueue.sort((a, b) => a.cost - b.cost);
    let current = priorityQueue.shift();
    let currentCity = current.city;
    if (currentCity === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    visitedOrder.push(currentCity);
    for (let [neighbor, weight] of romaniaMap[currentCity]) {
      let newCost = costs[currentCity] + weight;
      if (costs[neighbor] === undefined || newCost < costs[neighbor]) {
        costs[neighbor] = newCost;
        parentMap[neighbor] = currentCity;
        priorityQueue.push({ city: neighbor, cost: newCost });
      }
    }
  }
  return { path: null, visitedOrder };
}
function ucsGraphSearch(start, goal) {
  let priorityQueue = [{ city: start, cost: 0 }];
  let visited = new Set();
  let parentMap = {};
  let costs = { [start]: 0 };
  let visitedOrder = [];
  while (priorityQueue.length > 0) {
    priorityQueue.sort((a, b) => a.cost - b.cost);
    let current = priorityQueue.shift();
    let currentCity = current.city;
    if (currentCity === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    if (visited.has(currentCity)) continue;
    visited.add(currentCity);
    visitedOrder.push(currentCity);
    for (let [neighbor, weight] of romaniaMap[currentCity]) {
      let newCost = costs[currentCity] + weight;
      if (!visited.has(neighbor) && (costs[neighbor] === undefined || newCost < costs[neighbor])) {
        costs[neighbor] = newCost;
        parentMap[neighbor] = currentCity;
        priorityQueue.push({ city: neighbor, cost: newCost });
      }
    }
  }
  return { path: null, visitedOrder };
}
function greedyTreeSearch(start, goal) {
  let priorityQueue = [{ city: start, cost: straightLineDistances[start] }];
  let parentMap = {};
  let visitedOrder = [];
  while (priorityQueue.length > 0) {
    priorityQueue.sort((a, b) => a.cost - b.cost);
    let current = priorityQueue.shift().city;
    if (current === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    for (let neighbor of romaniaMap[current]) {
      let neighborCity = neighbor[0];
      if (!parentMap[neighborCity]) {
        priorityQueue.push({ city: neighborCity, cost: straightLineDistances[neighborCity] });
        visitedOrder.push(neighborCity);
        parentMap[neighborCity] = current;
      }
    }
  }
  return { path: null, visitedOrder };
}
function greedyGraphSearch(start, goal) {
  let priorityQueue = [{ city: start, cost: straightLineDistances[start] }];
  let visited = new Set();
  let parentMap = {};
  let visitedOrder = [];
  while (priorityQueue.length > 0) {
    priorityQueue.sort((a, b) => a.cost - b.cost);
    let current = priorityQueue.shift().city;
    if (current === goal) {
      return { path: reconstructPath(parentMap, start, goal), visitedOrder };
    }
    visited.add(current);
    for (let neighbor of romaniaMap[current]) {
      let neighborCity = neighbor[0];
      if (!visited.has(neighborCity) && !parentMap[neighborCity]) {
        priorityQueue.push({ city: neighborCity, cost: straightLineDistances[neighborCity] });
        visitedOrder.push(neighborCity);
        parentMap[neighborCity] = current;
      }
    }
  }
  return { path: null, visitedOrder };
}
function aStarTreeSearch(start, goal) {
  let openSet = [start];
  let cameFrom = {};
  let gScore = {};
  let fScore = {};
  let visitedOrder = [];
  for (let city in straightLineDistances) {
    gScore[city] = Infinity;
    fScore[city] = Infinity;
  }
  gScore[start] = 0;
  fScore[start] = straightLineDistances[start];
  while (openSet.length > 0) {
    let current = openSet.reduce((a, b) => fScore[a] < fScore[b] ? a : b);
    if (current === goal) {
      return { path: reconstructPath(cameFrom, start, goal), visitedOrder };
    }
    openSet = openSet.filter(city => city !== current);
    for (let [neighbor, weight] of romaniaMap[current]) {
      visitedOrder.push(neighbor);
      let tentative_gScore = gScore[current] + weight;
      if (tentative_gScore < gScore[neighbor]) {
        cameFrom[neighbor] = current;
        gScore[neighbor] = tentative_gScore;
        fScore[neighbor] = gScore[neighbor] + straightLineDistances[neighbor];
        if (!openSet.includes(neighbor)) {
          openSet.push(neighbor);
        }
      }
    }
  }
  return { path: null, visitedOrder };
}
function aStarGraphSearch(start, goal) {
  let openSet = [start];
  let visited = new Set();
  let cameFrom = {};
  let gScore = {};
  let fScore = {};
  let visitedOrder = [];
  for (let city in straightLineDistances) {
    gScore[city] = Infinity;
    fScore[city] = Infinity;
  }
  gScore[start] = 0;
  fScore[start] = straightLineDistances[start];
  while (openSet.length > 0) {
    let current = openSet.reduce((a, b) => fScore[a] < fScore[b] ? a : b);
    if (current === goal) {
      return { path: reconstructPath(cameFrom, start, goal), visitedOrder };
    }
    openSet = openSet.filter(city => city !== current);
    visited.add(current);
    for (let [neighbor, weight] of romaniaMap[current]) {
      if (visited.has(neighbor)) continue;
      visitedOrder.push(neighbor);
      let tentative_gScore = gScore[current] + weight;
      if (tentative_gScore < gScore[neighbor]) {
        cameFrom[neighbor] = current;
        gScore[neighbor] = tentative_gScore;
        fScore[neighbor] = gScore[neighbor] + straightLineDistances[neighbor];
        if (!openSet.includes(neighbor)) {
          openSet.push(neighbor);
        }
      }
    }
  }
  return { path: null, visitedOrder };
}
function resetCanvas() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  drawMap();
}
function reconstructPath(parentMap, start, goal) {
  let path = [goal];
  let current = goal;
  while (current !== start) {
    current = parentMap[current];
    path.unshift(current);
  }
  return path;
}
function getInputCities() {
  const startCity = document.getElementById('startCity').value;
  const goalCity = document.getElementById('goalCity').value;
  return { startCity, goalCity };
}
function startBFSTreeSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = bfsTreeSearch(startCity, goalCity);
  if (path) {
    displayResult("BFS 树搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startBFSGraphSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = bfsGraphSearch(startCity, goalCity);
  if (path) {
    displayResult("BFS 图搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startDFSTreeSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = dfsTreeSearch(startCity, goalCity);
  if (path) {
    displayResult("DFS 树搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startDFSGraphSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = dfsGraphSearch(startCity, goalCity);
  if (path) {
    displayResult("DFS 图搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startUCSTreeSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = ucsTreeSearch(startCity, goalCity);
  if (path) {
    displayResult("UCS 树搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startUCSGraphSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = ucsGraphSearch(startCity, goalCity);
  if (path) {
    displayResult("UCS 图搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startGreedyTreeSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = greedyTreeSearch(startCity, goalCity);
  if (path) {
    displayResult("贪婪 树搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startGreedyGraphSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = greedyGraphSearch(startCity, goalCity);
  if (path) {
    displayResult("贪婪 图搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startAStarTreeSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = aStarTreeSearch(startCity, goalCity);
  if (path) {
    displayResult("A* 树搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function startAStarGraphSearch() {
  resetCanvas();
  let { startCity, goalCity } = getInputCities();
  let { path, visitedOrder } = aStarGraphSearch(startCity, goalCity);
  if (path) {
    displayResult("A* 图搜索", path, visitedOrder);
    animatePath(path);
  } else {
    alert("未找到路径，请检查输入的城市名称。");
  }
}
function displayResult(searchMethod, path, visitedOrder) {
  const resultDiv = document.getElementById('result');
  resultDiv.innerHTML = `采用 ${searchMethod} 方法，得到的解为 ${path.join(' -> ')}，访问状态顺序为 ${visitedOrder.join(' -> ')}`;
}
function animatePath(path) {
  let index = 0;
  let totalWeight = 0;
  function step() {
    if (index >= path.length) {
      ctx.fillText(`总权值: ${totalWeight}`, 10, 30);
      return;
    }
    let city = path[index];
    let [x, y] = cityPositions[city];
    ctx.beginPath();
    ctx.arc(x, y, 10, 0, Math.PI * 2);
    ctx.fillStyle = 'green';
    ctx.fill();
    ctx.stroke();
    if (index > 0) {
      let prevCity = path[index - 1];
      let weight = 0;
      for (let [neighbor, w] of romaniaMap[prevCity]) {
        if (neighbor === city) {
          weight = w;
          totalWeight += weight;
          break;
        }
      }
      if (weight > 0) {
        let midX = (cityPositions[prevCity][0] + x) / 2;
        let midY = (cityPositions[prevCity][1] + y) / 2;
        ctx.fillText(weight, midX, midY - 5);
      }
    }
    index++;
    setTimeout(step, 500);
  }
  step();
}
drawMap();