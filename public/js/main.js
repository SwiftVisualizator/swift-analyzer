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
const defaultCircleColor = isDarkTheme ? "#2374AB" : "#3DBCD1"
const selectedCircleColor = isDarkTheme ? "#67AFE0" : "#2BA1B6"
const defaultCircleRadius = 15
const selectedCircleRadius = 20
const defaultCircleDistance = defaultCircleRadius * 20

// Link configuration
const defaultLinkColor = isDarkTheme ? "#BFCDE0" : "#E5E5E5"
const selectedLinkColor = isDarkTheme ? "#EA526F" : "#3DBCD1"

// Label configuration
const defaultLabelOffset = defaultCircleRadius + 4
const selectedLabelOffset = selectedCircleRadius + 6

// Data configuration
var selectedNodeIndex = null

// Setup visual elements

d3.select("body")
    .style("background-color", backgroundColor)

const svg = d3.select("svg")
    .attr("width", width)
    .attr("height", height);

var nodes = d3.select("#nodes")
    .selectAll("circle")
    .data(nodesData)
    .enter()
    .append('circle')
    .attr('r', defaultCircleRadius)
    .attr('fill', defaultCircleColor)

var links = d3.select("#links")
    .selectAll("line")
    .data(linksData)
    .enter()
    .append("line")
    .attr('stroke-width', 1)
    .attr('stroke', defaultLinkColor)

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
    .force("center_force", d3.forceCenter(width / 2, height / 2))
    .force("charge_force", d3.forceManyBody().strength(-40))
    .force("links", d3.forceLink(linksData).id(datum => datum.name).distance(defaultCircleDistance))
    .on("tick", () => {
        nodes
            .attr("cx", datum => datum.x)
            .attr("cy", datum => datum.y);

        labels
            .attr("x", datum => datum.x)
            .attr("y", datum => datum.y);
        
        links
            .attr("x1", datum => datum.source.x)
            .attr("y1", datum => datum.source.y)
            .attr("x2", datum => datum.target.x)
            .attr("y2", datum => datum.target.y);
    });

const dragDrop = d3.drag()
    .on('start', event => {
        if (!event.active) {
            simulation.alphaTarget(0.3).restart()
        }

        event.subject.x = event.x
        event.subject.y = event.y
    })
    .on('drag', event => {
        event.subject.x = event.x
        event.subject.y = event.y
    })
    .on('end', event => {
        event.x = null
        event.y = null
    })

nodes.call(dragDrop)
labels.call(dragDrop)

function selectNode(event) {
    const selectedNode = event.target.__data__
    
    if (selectedNodeIndex == selectedNode.index) {
        selectedNodeIndex = null
    } else {
        selectedNodeIndex = selectedNode.index
    }

    function isSelected(node) {
        return selectedNodeIndex != null && selectedNodeIndex == node.index
    }

    let adjacentLinkIndices = linksData
        .filter(link => (link.source.index == selectedNodeIndex || link.target.index == selectedNodeIndex))
        .map(link => link.index );

    nodes
        .transition()
        .duration(150)
        .ease(d3.easeLinear)
        .attr('r', node => isSelected(node) ? selectedCircleRadius : defaultCircleRadius)
        .attr('fill', node => isSelected(node) ? selectedCircleColor : defaultCircleColor);

    labels
        .transition()
        .duration(150)
        .ease(d3.easeLinear)
        .attr('dx', node => isSelected(node) ? selectedLabelOffset : defaultLabelOffset)


    links
        .transition()
        .duration(150)
        .ease(d3.easeLinear)
        .attr('stroke', link => {
            return adjacentLinkIndices.includes(link.index) ? selectedLinkColor : defaultLinkColor
        })
}

nodes.on('click', selectNode)
labels.on('click', selectNode)
