//
//
//  MIT License
//
//  Copyright (c) 2022-Present
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

const width = window.innerWidth
const height = window.innerHeight

var isDarkTheme = false
if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    isDarkTheme = false
}

// Body configuration
const backgroundColor = isDarkTheme ? "#140F2D" : "#FFFFFF"

// Circle configuration
const nodeColors = {
    class: {
        default: {
            dark: "#2374AB",
            light: "#3DBCD1"
        },
        selected: {
            dark: "#67AFE0",
            light: "#2BA1B6"
        }
    },
    struct: {
        default: {
            dark: "#FFA726",
            light: "#FFCC80"
        },
        selected: {
            dark: "#FFC107",
            light: "#FFEB3B"
        }
    },
    enum: {
        default: {
            dark: "#D32F2F",
            light: "#EF5350"
        },
        selected: {
            dark: "#F44336",
            light: "#FF8A80"
        }
    },
    protocol: {
      default: {
          dark: "#6A1B9A",
          light: "#9C27B0"
      },
      selected: {
          dark: "#BA68C8",
          light: "#CE93D8"
      }
    },
    root: {
        default: {
            dark: "#388E3C",
            light: "#66BB6A"
        },
        selected: {
            dark: "#4CAF50",
            light: "#81C784"
        }
    }
};

function getNodeColor(nodeType, isSelected = false) {
    if (nodeColors[nodeType]) {
        if (isSelected) {
          return isDarkTheme ? nodeColors[nodeType].selected.dark : nodeColors[nodeType].selected.light;
        } else {
          return isDarkTheme ? nodeColors[nodeType].default.dark : nodeColors[nodeType].default.light;
        }
      } else {
        // Return default color if the node type is not defined in the configuration
        return isDarkTheme ? "#999" : "#ccc";
      }
}

const defaultCircleRadius = 12
const selectedCircleRadius = 22
const defaultCircleDistance = defaultCircleRadius * 20

// Link configuration
const defaultLinkColor = isDarkTheme ? "#9FA8DA" : "#B0BEC5";
const selectedLinkColor = isDarkTheme ? "#EF5350" : "#2196F3";


// Label configuration
const defaultLabelOffset = defaultCircleRadius + 4
const selectedLabelOffset = selectedCircleRadius + 6

// Data configuration
var selectedNodeIndex = null

function isSelected(node) {
    return selectedNodeIndex != null && selectedNodeIndex == node.index;
}

// Preprocess data

// Create a Set containing the names of all nodes
const originalNodesData = rawNodesData;
const nodeNamesSet = new Set(originalNodesData.map(node => node.name));

// Filter out links that don't have a corresponding source or target in the nodes array
const originalLinksData = rawLinksData.filter(link => (
  nodeNamesSet.has(link.source) && nodeNamesSet.has(link.target)
));


// Setup visual elements

d3.select("body")
    .style("background-color", backgroundColor)

const svg = d3.select("svg")
    .attr("width", width)
    .attr("height", height);

const markerWidth = 10;
const markerHeight = 10;
const refX = markerWidth / 2;

svg.append("defs")
  .selectAll("marker")
  .data(["arrow"])
  .enter()
  .append("marker")
  .attr("id", d => d)
  .attr("viewBox", `0 -${markerHeight/2} ${markerWidth} ${markerHeight}`)
  .attr("refX", refX)
  .attr("refY", 0)
  .attr("markerWidth", markerWidth)
  .attr("markerHeight", markerHeight)
  .attr("orient", "auto")
  .append("path")
  .attr("d", `M0,-${markerHeight/2}L${markerWidth},0L0,${markerHeight/2}`)
  .attr("fill", defaultLinkColor);

d3.select("defs")
  .append("marker")
  .attr("id", "arrow-selected")
  .attr("viewBox", `0 -${markerHeight/2} ${markerWidth} ${markerHeight}`)
  .attr("refX", refX)
  .attr("refY", 0)
  .attr("markerWidth", markerWidth)
  .attr("markerHeight", markerHeight)
  .attr("orient", "auto")
  .append("path")
  .attr("d", `M0,-${markerHeight/2}L${markerWidth},0L0,${markerHeight/2}`)
  .attr("fill", selectedLinkColor);

var nodes = null
var links = null
var labels = null

const simulation = d3.forceSimulation()
  .force("collision_force", d3.forceCollide().radius(node => getCollisionRadius(node)))
  .force("center_force", d3.forceCenter(width / 2, height / 2))
  .force("charge_force", d3.forceManyBody().strength(-150).distanceMin(50).distanceMax(200))
  .force("radial_force", d3.forceRadial(200, width / 2, height / 2))

const dragDrop = d3.drag()
    .on('start', event => {
        if (!event.active) simulation.alphaTarget(0.3).restart();
        event.subject.fx = event.subject.x;
        event.subject.fy = event.subject.y;
    })
    .on('drag', event => {
        event.subject.fx = event.x;
        event.subject.fy = event.y;
    })
    .on('end', event => {
        if (!event.active) simulation.alphaTarget(0);
        event.subject.fx = null;
        event.subject.fy = null;
    })

function applyFilter(filterFunction = node => true) {
  const nodesData = structuredClone(originalNodesData)
  const linksData = structuredClone(originalLinksData)

  const filteredNodesData = nodesData.filter(filterFunction);
  const filteredNodeNames = new Set(filteredNodesData.map(node => node.name));

  const filteredLinksData = linksData.filter(link => 
    filteredNodeNames.has(link.source) && filteredNodeNames.has(link.target)
  );

  nodes = d3.select("#nodes")
    .selectAll("circle")
    .data(filteredNodesData)
    .join(
      enter => enter.append('circle')
        .attr('r', defaultCircleRadius)
        .attr('fill', (node) => getNodeColor(node.type)),
      update => update,
      exit => exit.remove()
    );

  links = d3.select("#links")
      .selectAll("line")
      .data(filteredLinksData)
      .join(
        enter => enter.append("line")
          .attr('stroke-width', 1)
          .attr('stroke', defaultLinkColor)
          .attr("marker-end", "url(#arrow)"),
        update => update,
        exit => exit.remove()
      );

  labels = d3.select("#labels")
    .selectAll('text')
    .data(filteredNodesData)
    .join(
      enter => enter.append('text')
        .text(node => node.name)
        .attr('font-weight', 700)
        .attr('font-size', 16)
        .attr('dx', defaultLabelOffset),
      update => update,
      exit => exit.remove()
    );
  
  simulation
    .nodes(filteredNodesData)
    .force("links", d3.forceLink(filteredLinksData).id(datum => datum.name).distance(defaultCircleDistance).strength(0.8))
    .on("tick", () => {
        nodes
            .attr("cx", datum => {
                constrainNodePosition(datum, defaultCircleRadius);
                return datum.x;
            })
            .attr("cy", datum => {
                constrainNodePosition(datum, defaultCircleRadius);
                return datum.y;
            })
            .attr('r', node => isSelected(node) ? selectedCircleRadius : defaultCircleRadius)
            .attr('fill', node => getNodeColor(node.type, isSelected(node)));

        labels
            .attr("x", datum => datum.x)
            .attr("y", datum => datum.y)
            .text(node => node.name)
            .attr('dx', node => isSelected(node) ? selectedLabelOffset : defaultLabelOffset);
        
        links
            .attr("x1", datum => datum.source.x)
            .attr("y1", datum => datum.source.y)
            .attr('marker-end', link => {
              const adjacentLinkIndices = filteredLinksData
                .filter(link => (link.source.index == selectedNodeIndex || link.target.index == selectedNodeIndex))
                .map(link => link.index);
              return adjacentLinkIndices.includes(link.index) ? 'url(#arrow-selected)' : 'url(#arrow)'
            })
            .attr('x2', datum => {
              const radius = isSelected(datum.target) ? selectedCircleRadius : defaultCircleRadius;
              const { x } = getLineEndCoordinates(datum.source, datum.target, radius + refX);
              return x;
            })
            .attr('y2', datum => {
              const radius = isSelected(datum.target) ? selectedCircleRadius : defaultCircleRadius;
              const { y } = getLineEndCoordinates(datum.source, datum.target, radius + refX);
              return y;
            })
            .attr('stroke', link => {
              const adjacentLinkIndices = filteredLinksData
                .filter(link => (link.source.index == selectedNodeIndex || link.target.index == selectedNodeIndex))
                .map(link => link.index);
              return adjacentLinkIndices.includes(link.index) ? selectedLinkColor : defaultLinkColor
            });
    });

    nodes.call(dragDrop)
    labels.call(dragDrop)

    nodes.on('click', selectNode)
    labels.on('click', selectNode)

    simulation.alpha(1).restart();
}

applyFilter()

// Helpers

function getCollisionRadius(node) {
  return isSelected(node) ? selectedCircleRadius : defaultCircleRadius;
}

function selectNode(event) {
  const selectedNode = event.target.__data__;
  selectedNodeIndex = (selectedNodeIndex == selectedNode.index) ? null : selectedNode.index;
  enableTooltip(selectedNodeIndex == null ? null : selectedNode)
}

function constrainNodePosition(node, radius) {
    node.x = Math.max(radius, Math.min(width - radius, node.x));
    node.y = Math.max(radius, Math.min(height - radius, node.y));
}
  

function getLineEndCoordinates(source, target, radius) {
    const dx = target.x - source.x;
    const dy = target.y - source.y;
    const angle = Math.atan2(dy, dx);
    const x = target.x - Math.cos(angle) * radius;
    const y = target.y - Math.sin(angle) * radius;
    return { x, y };
}

const filterSelector = document.querySelector('.filter-selector');

function onFilterSelection(event) {
    const selector = event.target;
    const value = selector.value;

    var selectedValues = value !== '' ? JSON.parse(value) : [];

    const filterPredicate = node => {
      if (selectedValues.length === 0) {
        return true;
      } else {
        return selectedValues.includes(node.type);
      }
    };

    applyFilter(filterPredicate)
    enableTooltip(null)
}

filterSelector.addEventListener('change', onFilterSelection);

function enableTooltip(node) {
  const enabled = (node != null && node.metadata != null);
  const tooltip = d3.select("#tooltip");
  tooltip.classed("hidden", !enabled);

  if (enabled) {
    const declaration = tooltip.select("#declaration");

    const title = tooltip.select(".section-title");
    title.text(node.name);

    const code = declaration.select(".code");
    let declarationText = "";

    // Check if 'docs' property exists and add it to the declarationText
    if (node.metadata.docs) {
      declarationText += `<span class="comment">${node.metadata.docs}</span>\n`;
    }

    // Add modifiers to the declarationText
    if (node.metadata.modifiers) {
      node.metadata.modifiers.forEach((modifier) => {
        declarationText += `<span class="modifier">${modifier}</span> `;
      });
    }

    // Add type and name to the declarationText
    declarationText += `<span class="type">${node.type}</span> <span class="identifier">${node.name}</span>`;

    // Add generics to the declarationText if not empty
    if (node.metadata.generics && node.metadata.generics.length > 0) {
      declarationText += `<span class="generics">&lt;${node.metadata.generics.join(', ')}&gt;</span>`;
    }

    // Add inheritance to the declarationText if not empty
    if (node.metadata.inheritance && node.metadata.inheritance.length > 0) {
      declarationText += `: <span class="inheritance">${node.metadata.inheritance.join(', ')}</span>`;
    }

    code.html(declarationText);

    // Add location information to the tooltip
    const location = tooltip.select(".location");
    location.text(`Located at ${node.metadata.location}`);
  }
}
