package com.mallets.pathfinding
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import com.mallets.pathfinding.INode;
	import com.mallets.pathfinding.MlNode;
	import com.mallets.pathfinding.MlPathfinder;

	/**
	 * ...
	 * @author Francisco Prado
	 */
	public class MlMap extends Sprite
	{
		private var _nodes:Array;
		
		private var _cell_size:int = 20;
		private var _xml:XML;
		private var _obstacles:Array = new Array();
		private var _obstacles_sprites:Array = new Array();		
		private var _path:Array = new Array();
		
		private var _grid_width:Number = 100;
		private var _grid_height:Number = 50;
		
		private var _grid_container:Sprite = new Sprite();
		
		public var _startNode:INode;
		public var _endNode:INode;
		
		public function MlMap(xml_source:XML) 
		{
			_xml = xml_source;
			
			MlPathfinder.heuristic = MlPathfinder.euclidianHeuristic;
			
			_drawMap();
			
			_createNodes();
			
			_enableNodes();
		}
		
		private function _drawMap():Array {			
			for each(var obj:* in _xml.obstacles.object) {
				_createObstacle(obj.@x, obj.@y, obj.@width, obj.@height);
			}
			
			return _obstacles;
		}
		
		private function _createObstacle(x:Number, y:Number, width:Number, height:Number):void {
			var col:Number = width / _cell_size;
			var row:Number = height / _cell_size;
			
			for (var i:int = 0; i < col; i++) {
				
				for (var j:int = 0; j < row; j++) {
					var obs:MlObstacle = new MlObstacle(_cell_size);
					obs.x = (Math.floor(x / _cell_size) * _cell_size) + (i * _cell_size);
					obs.y = (Math.floor(y / _cell_size) * _cell_size) + (j * _cell_size);
					_obstacles.push(obs);
				}
			}
		}
		
		private function _createNodes():void {
			if (_grid_container && contains(_grid_container) )
				removeChild(_grid_container);			
			
			for each(var old_node:MlNode in _nodes)
				old_node = null;
			
			_grid_container = new Sprite();			
			_nodes = [];
			
			_drawNodes();
			
			_drawObstacles();
			
			addChild(_grid_container);
		}
		
		private function _drawNodes():void
		{
			var node:MlNode;
			
			for (var r:int = 0; r < _grid_height; r++) 
			{
				for (var c:int = 0; c < _grid_width; c++) 
				{
					node = new MlNode(r, c, _cell_size);
					node.x = c * node.W;
					node.y = r * node.H;
					_grid_container.addChild(node);
					
					if ( !_isObstacle(node.x, node.y) )
						_nodes.push(node);
					else
						node.highlight(0xffffff);
				}
			}
			
		}
		
		private function _isObstacle(pos_x:Number, pos_y:Number):Boolean {
			var is_obstacle:Boolean = false;
			
			for each(var obs:Object in _obstacles) {
				
				if (obs.x == pos_x && obs.y == pos_y) {
					is_obstacle = true;
					break;					
				}
			}
			
			return is_obstacle;
        }
		
		public function onResetClick(e:MouseEvent):void 
		{
			_startNode = null;
			_endNode = null;
			
			_createNodes();
			
			_enableNodes();
		}
		
		private function _enableNodes():void
		{
			var node:MlNode;
			for (var i:int = 0; i < _nodes.length; i++) 
			{
				node = _nodes[i];
				
				node.buttonMode = true;
				node.addEventListener(MouseEvent.ROLL_OVER, _onNodeOver, false, 0, true);
				node.addEventListener(MouseEvent.ROLL_OUT, _onNodeOut, false, 0, true);
				node.addEventListener(MouseEvent.CLICK, _onNodeClick, false, 0, true);				
			}			
		}
		
		private function _findConnectedNodes( node: INode ):Array	{
			var n:MlNode = node as MlNode;
			var connectedNodes:Array = [];			
			var testNode:MlNode;
			
			for (var i:int = 0; i < _nodes.length; i++) {
				testNode = _nodes[i];
				if (testNode.row < n.row - 1 || testNode.row > n.row + 1) continue;
				if (testNode.col < n.col - 1 || testNode.col > n.col + 1) continue;
				
				connectedNodes.push( testNode );
			}
			
			return connectedNodes;
		}
		
		public function definePath(start_point:Point, end_point:Point):Array {
			var start_x:Number = Math.round(start_point.x / _cell_size) * _cell_size;
			var start_y:Number = Math.round(start_point.y / _cell_size) * _cell_size;
			var end_x:Number = Math.round(end_point.x / _cell_size) * _cell_size;
			var end_y:Number = Math.round(end_point.y / _cell_size) * _cell_size;
			var n:MlNode;
			
			_path = [];
			
			_setStartNode(start_x, start_y);
			_setEndNode(end_x, end_y);
			
			if (_startNode && _endNode)
			{
				var p_nodes:Array = MlPathfinder.findPath(_startNode, _endNode, _findConnectedNodes);
				
				for (var i:int = 0; i < p_nodes.length; ++i) {
					n = p_nodes[i];
					n.highlight(0xFFFF00);
					_path.push( { x: n.x, y: n.y } );
				}
			}
			else 
			{
				_path = [0, 0, _cell_size * 2, _cell_size * 2];
			}
			
			return _path;
		}
		
		private function _setStartNode(start_x:Number, start_y:Number):void
		{
			for each(var _i:MlNode in _nodes) 
			{
				if (_i.x == start_x && _i.y == start_y)
					_startNode = _i;
			}
		}
		
		private function _setEndNode(end_x:Number, end_y:Number):void
		{
			for each(var _f:MlNode in _nodes) 
			{
				if (_f.x == end_x && _f.y == end_y)
					_endNode = _f;
			}
		}
		
		private function _drawObstacles():void {
			for each(var obstacle:MlObstacle in _obstacles) 
			{
				_grid_container.addChild(obstacle);
			}
		}
		
		// for tests
		private function _drawPath(nodes:Array):void {
			if (!nodes) return;
			
			_disableNodes();
			
			var n:MlNode;		
			
			for (var i:int = 0; i < nodes.length; ++i) {
				n = nodes[i];
				n.highlight(0xFFFF00);
			}
		}
		
		private function _disableNodes():void
		{
			var node:MlNode;
			for (var i:int = 0; i < _nodes.length; i++) 
			{
				node = _nodes[i];
				
				node.buttonMode = false;
				node.removeEventListener(MouseEvent.ROLL_OVER, _onNodeOver);
				node.removeEventListener(MouseEvent.ROLL_OUT, _onNodeOut);
				node.removeEventListener(MouseEvent.CLICK, _onNodeClick);
			}			
		}
		
		private function set _obstaclesVisible(_param:Boolean):void {
			for each(var obs:MlObstacle in _obstacles_sprites) {
				obs.visible = _param;
			}
		}
		
		//---- EVENT HANDLERS -------------------------------------------------------------------------
		private function _onNodeClick(e:MouseEvent):void 
		{
			var node:MlNode = e.currentTarget as MlNode;
			if (!_startNode) {
				_startNode = node;
				node.highlight( 0xFF0000 );
				node.buttonMode = false;
				return;
			}
			
			if (node == _startNode) return;
			
			node.buttonMode = false;
			
			_endNode = node;
			
			node.highlight( 0xFF0000 );
			
			_drawPath( MlPathfinder.findPath(_startNode, _endNode, _findConnectedNodes) );
		}			
		
		private function _onNodeOver(e:MouseEvent):void 
		{
			var node:MlNode = e.currentTarget as MlNode;
			if(node != _startNode && node != _endNode) node.highlight( 0xD5FFD5 );
		}
		
		private function _onNodeOut(e:MouseEvent):void 
		{
			var node:MlNode = e.currentTarget as MlNode;
			if(node != _startNode && node != _endNode) node.highlight();
		}
	}

}