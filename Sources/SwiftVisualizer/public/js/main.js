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
    }
};

function getNodeColor(nodeType, isSelected) {
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
const selectedCircleRadius = 16
const defaultCircleDistance = defaultCircleRadius * 20

// Link configuration
const defaultLinkColor = isDarkTheme ? "#BFCDE0" : "#E5E5E5"
const selectedLinkColor = isDarkTheme ? "#EA526F" : "#3DBCD1"

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
const nodesData = rawNodesData;
const nodeNamesSet = new Set(nodesData.map(node => node.name));

// Filter out links that don't have a corresponding source or target in the nodes array
const linksData = rawLinksData.filter(link => (
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

var nodes = d3.select("#nodes")
    .selectAll("circle")
    .data(nodesData)
    .enter()
    .append('circle')
    .attr('r', defaultCircleRadius)
    .attr('fill', (node) => getNodeColor(node.type, false))

var links = d3.select("#links")
    .selectAll("line")
    .data(linksData)
    .enter()
    .append("line")
    .attr('stroke-width', 1)
    .attr('stroke', defaultLinkColor)
    .attr("marker-end", "url(#arrow)");

var labels = d3.select("#labels")
    .selectAll('text')
    .data(nodesData)
    .enter()
    .append('text')
    .text(node => node.name)
    .attr('font-size', 15)
    .attr('dx', defaultLabelOffset)

const simulation = d3.forceSimulation()
    .nodes(nodesData)
    .force("collision_force", d3.forceCollide(defaultCircleRadius + 1))
    .force("center_force", d3.forceCenter(width / 2, height / 2))
    .force("charge_force", d3.forceManyBody().strength(-100).distanceMin(100).distanceMax(300))
    .force("links", d3.forceLink(linksData).id(datum => datum.name).distance(defaultCircleDistance).strength(0.8))
    .on("tick", () => {
        nodes
            .attr("cx", datum => {
                constrainNodePosition(datum, defaultCircleRadius);
                return datum.x;
            })
            .attr("cy", datum => {
                constrainNodePosition(datum, defaultCircleRadius);
                return datum.y;
            });

        labels
            .attr("x", datum => datum.x)
            .attr("y", datum => datum.y);
        
        links
            .attr("x1", datum => datum.source.x)
            .attr("y1", datum => datum.source.y)
            .attr("x2", datum => {
                const radius = isSelected(datum.target) ? selectedCircleRadius : defaultCircleRadius;
                const { x } = getLineEndCoordinates(datum.source, datum.target, radius + refX);
                return x;
            })
            .attr("y2", datum => {
                const radius = isSelected(datum.target) ? selectedCircleRadius : defaultCircleRadius;
                const { y } = getLineEndCoordinates(datum.source, datum.target, radius + refX);
                return y;
            });
    });

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

nodes.call(dragDrop)
labels.call(dragDrop)

function selectNode(event) {
    const selectedNode = event.target.__data__;
    selectedNodeIndex = (selectedNodeIndex == selectedNode.index) ? null : selectedNode.index;

    const adjacentLinkIndices = linksData
      .filter(link => (link.source.index == selectedNodeIndex || link.target.index == selectedNodeIndex))
      .map(link => link.index);
  
    nodes
      .transition()
      .duration(150)
      .ease(d3.easeLinear)
      .attr('r', node => isSelected(node) ? selectedCircleRadius : defaultCircleRadius)
      .attr('fill', node => getNodeColor(node.type, isSelected(node)));
  
    labels
      .transition()
      .duration(150)
      .ease(d3.easeLinear)
      .attr('dx', node => isSelected(node) ? selectedLabelOffset : defaultLabelOffset);
  
    links
      .transition()
      .duration(150)
      .ease(d3.easeLinear)
      .attr('marker-end', link => adjacentLinkIndices.includes(link.index) ? 'url(#arrow-selected)' : 'url(#arrow)')
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
      .attr('stroke', link => adjacentLinkIndices.includes(link.index) ? selectedLinkColor : defaultLinkColor);
  }

nodes.on('click', selectNode)
labels.on('click', selectNode)

// Helpers

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