angular.module('todoApp',[])
 .controller('TodoListController',function(){
	var todoList = this;
	todoList.todos = [
	 {text:"学习angular",done:true},
	 {text:"建立一个angular APP",done:false}
	];
	todoList.addTodo = function(){
		todoList.todos.push({text:todoList.todoText,done:false});
		todoList.todoText = '';
	};
	
	todoList.remaining = function(){
		var count = 0;
		angular.forEach(todoList.todos,function(todo){
			count += todo.done? 0:1;
		});
		return count;
	}
 });