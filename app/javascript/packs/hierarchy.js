import * as d3 from 'd3';

// データの定義
const data = {
  name: "Window",
  children: [
    {
      name: "Document",
      children: [
        {
          name: "HTMLDocument",
          children: [
            {
              name: "HTMLElement",
              children: [
                { name: "HTMLHtmlElement" },
                { name: "HTMLHeadElement" },
                { name: "HTMLTitleElement" },
                { name: "HTMLMetaElement" },
                { name: "HTMLLinkElement" },
                { name: "HTMLStyleElement" },
                { name: "HTMLBodyElement" },
                { name: "HTMLHeadingElement" },
                { name: "HTMLParagraphElement" },
                { name: "HTMLDivElement" },
                { name: "HTMLAnchorElement" },
                { name: "HTMLImageElement" },
                { name: "HTMLTableElement" },
                { name: "HTMLTableRowElement" },
                { name: "HTMLTableCellElement" },
                { name: "HTMLFormElement" },
                { name: "HTMLInputElement" }
              ]
            }
          ]
        },
        {
          name: "SVGDocument",
          children: [
            {
              name: "SVGElement",
              children: [
                { name: "SVGSVGElement" },
                { name: "SVGPathElement" },
                { name: "SVGRectElement" }
              ]
            }
          ]
        },
        { name: "Text" },
        { name: "Comment" },
        { name: "DocumentFragment" }
      ]
    },
    {
      name: "Navigator",
      children: [
        {
          name: "NavigatorPlugins",
          children: [
            { name: "Plugin" },
            { name: "MimeType" }
          ]
        },
        {
          name: "NavigatorStorage",
          children: [
            { name: "StorageManager" }
          ]
        },
        { name: "NavigatorID" },
        { name: "NavigatorOnLine" },
        { name: "NavigatorContentUtils" },
        { name: "NavigatorCookies" },
        { name: "NavigatorLanguage" },
        { name: "NavigatorConcurrentHardware" },
        { name: "NavigatorGeolocation" },
        { name: "NavigatorMediaDevices" },
        { name: "NavigatorLocks" },
        { name: "NavigatorPermissions" },
        { name: "NavigatorPresentation" },
        { name: "NavigatorUAData" }
      ]
    },
    { name: "Screen" },
    { name: "History" },
    { name: "Location" },
    { name: "Console" },
    {
      name: "Storage",
      children: [
        { name: "localStorage" },
        { name: "sessionStorage" }
      ]
    },
    { name: "Performance" },
    { name: "Crypto" },
    { name: "Custom Elements" },
    { name: "BroadcastChannel" }
  ]
};

// SVG要素の設定
const width = 1200;
const height = 800;

const svg = d3.select("body")
  .append("svg")
  .attr("width", width)
  .attr("height", height);

const root = d3.hierarchy(data);

const treeLayout = d3.tree().size([width, height - 200]);

treeLayout(root);

const links = svg.selectAll(".link")
  .data(root.links())
  .enter()
  .append("line")
  .classed("link", true)
  .attr("x1", d => d.source.x)
  .attr("y1", d => d.source.y)
  .attr("x2", d => d.target.x)
  .attr("y2", d => d.target.y)
  .style("stroke", "#ccc");

const nodes = svg.selectAll(".node")
  .data(root.descendants())
  .enter()
  .append("g")
  .classed("node", true)
  .attr("transform", d => `translate(${d.x}, ${d.y})`);

nodes.append("circle")
  .attr("r", 5)
  .style("fill", "#000");

nodes.append("text")
  .attr("dy", -10)
  .attr("text-anchor", "middle")
  .text(d => d.data.name);
