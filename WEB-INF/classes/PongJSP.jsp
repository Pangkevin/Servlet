<%@ page import="java.util.*"%>


<%
if(request.getParameter("username")!=null){
	if(request.getParameter("userX") != null){
		session.setAttribute("username",request.getParameter("userX").toString());
	}
	else if(request.getParameter("userY") != null){
			session.setAttribute("username",request.getParameter("userY").toString());
		}
	
}

%>
<!DOCTYPE html>
<html>
<head>

<title>Pong !</title>
<script>
  var dir = Math.round(Math.random()); //Left or right for ball
  var axe = Math.round(Math.random()); //up or down for ball
  var aip = Math.round(Math.random()); // left or right for AI
  var scoreA = 1; //score for player A
  var scoreB = 1; //score for player B
  var vit; //Speed incrementation
  var speed = 20;
  var ia;  //AI activation
  var lancement; //Gamestart

  
//Ball object
var ball = new Object();
ball.ballx = Math.floor(Math.random() * 400) + 10;
ball.bally = 189;
ball.speed = 1;

// AJAX
var requete;

function valider() {
	console.log("la")
	   var url ="http://localhost:8080/Servlet/pong?dir=2"; /* "pong"+"?dir="+dir+"&"+"axe="+axe+"&"+"aip="+aip+"&"+"scoreA="+scoreA+"&"+"scoreB="+scoreB+"&"+"vit="+vit+"&"+"speed="+speed+"&"+"ia="+ia+"&"
	   +"lancement="+lancement+"&"+"ballx="+ball.ballx+"&"+"bally="+ball.bally +"&"+"ballSpeed="+ball.speed+"&"+"pxPlayerX="+player1.px+"&"+"pyPlayerX="+player1.py+"&"+"pheighPlayerX="+player1.pheigh+"&"+"pwidthPlayerX="+player1.pwidth+"&"
	   +"pxPlayerY="+player2.px+"&"+"pyPlayerY="+player2.py+"&"+"pheighPlayerY="+player1.pheigh+"&"+"pwidthPlayerY="+player1.pwidth; */
	   
	   if (window.XMLHttpRequest) {
		  
	      requete = new XMLHttpRequest();
	      console.log(requete)
	      requete.open("GET", url, true);
	      requete.onreadystatechange = updateDataPong;
	      requete.send(null);  
	         
	   } else if (window.ActiveXObject) {
		   
	      requete = new ActiveXObject("Microsoft.XMLHTTP");
	      if (requete) {
	         requete.open("GET", url, true);
	         requete.onreadystatechange = updateDataPong;
	         requete.send();  
	      }
	   } else {
	      alert("Le navigateur ne supporte pas la technologie AJAX");
	   }
	}	

function updateDataPong() {
	 

	  if (requete.readyState == 4) {
	    if (requete.status == 200) {
	      // exploitation des données de la réponse
	      console.log(requete);
	      console.log(requete.responseXML);
	      /* var messageTag = requete.responseXML.getElementsByTagName("dir")[0];
	   		// A compléter
	   		console.log(messageTag);
	      message = messageTag.childNodes[0].nodeValue;
	    	alert(message);
	       */
	    }
	  }
	}

//Player prototype
function Player(px, py) {
    this.px = px;
    this.py = py;
    this.pheigh = 50;
    this.pwidth = 5;
}

var player1 = new Player(300, 15);
var player2 = new Player(80, 400);
  
function drawgameboard(){
  var canvas=document.getElementById("gameboard");
  if(!canvas.getContext){return;}
 
  //Board
  var ctx=canvas.getContext("2d");
  ctx.fillStyle = "#000000"; 
  ctx.clearRect(10,10,400,400);
  
  ctx.fillRect(10,10,400,400);

  // Ball
  ctx.fillStyle = "#3370d4"; 
  ctx.beginPath();
  
  ctx.arc(ball.ballx,ball.bally,5,0,2*Math.PI,true);
  ctx.fill();
  ctx.stroke();
  
  //Player 1
  ctx.fillStyle = "#c2b675"; 
  ctx.clearRect(player1.px,player1.py,player1.pheigh, player1.pwidth);
  ctx.fillRect(player1.px, player1.py,player1.pheigh, player1.pwidth);
  ctx.stroke();

  //Player 2
  ctx.fillStyle = "#279890";
  ctx.clearRect(player2.px,player2.py,player2.pheigh,player2.pwidth);
  ctx.fillRect(player2.px,player2.py,player2.pheigh,player2.pwidth);
  ctx.stroke();
}

function downball(){
if (ball.bally < 400){
  ball.bally++;
    }
  if(ball.bally == player2.py-5){
if((ball.ballx >= player2.px+10) && (ball.ballx <= player2.px+40)){
    	axe = 1;
        drawgameboard();
    	}
        else if((ball.ballx >= player2.px-2 & ball.ballx < player2.px+10) || (ball.ballx <= player2.px+52 & ball.ballx > player2.px+40)){
        vit = setInterval(move,speed) ;
                ball.speed +=1;
            	axe = 1;
        drawgameboard();
        }
        else{
      renitPosition();
        var resultG = document.getElementById("Resultgreen");
        resultG.value = scoreA;
        scoreA++;
        }
    }
}


function upball(){
if (ball.bally > 20){
  ball.bally--;
    }
  if(ball.bally == player1.py+10){
if((ball.ballx >= player1.px+10) && (ball.ballx <= player1.px+40)){
    	axe = 0;
        drawgameboard();
    	}
        else if((ball.ballx >= player1.px-2 & ball.ballx < player1.px+10) || (ball.ballx <= player1.px+52 & ball.ballx > player1.px+40)){
        vit = setInterval(move,speed);
        ball.speed +=1;
            	axe = 0;
        drawgameboard();
        }
        else{
      renitPosition();
        var resultR = document.getElementById("Resultred");
        resultR.value = scoreB;
        scoreB++;
        }
    }
}


function rightball(){
if ((ball.bally != 400 || ball.bally != 15)  && (ball.ballx <= 394 || ball.ballx >= 21)){
  ball.ballx++;}
  if(ball.ballx == 404 && !((ball.ballx <= player2.px-10 && ball.ballx >= player2.px+10) && ball.bally == 395))
    dir = 0;
  drawgameboard();
}

function leftball(){
if ((ball.bally != 400 || ball.bally != 15)  && (ball.ballx <= 394 || ball.ballx >= 21)) { // verifie qu'on est pas au bord
  
  ball.ballx--;
}
  if(ball.ballx == 16 && !((ball.ballx >= player1.px-10 && ball.ballx <= player1.px+10) && ball.bally == 20))
    dir = 1;
  drawgameboard();
}

//Ball movement
function move(){
  if(dir) rightball(); else leftball();
    if(axe) upball(); else downball();
        var xSpeed = document.getElementById("speedx");
        var ySpeed = document.getElementById("speedy");
        var bSpeed = document.getElementById("speedb");
        xSpeed.value = ball.ballx/speed*ball.speed;
        ySpeed.value = ball.bally/speed*ball.speed;
		bSpeed.value = ball.speed;
}


function startball() {
  clearInterval(vit);
}

function renitPosition(){
  //alert("Un joueur a marquÃ©");
       ball.ballx = Math.floor(Math.random() * 400) + 10;
       ball.bally = 210;
       dir = Math.round(Math.random());
       axe = Math.round(Math.random());
       startball();
       gamestop();
       gamestart();
       ball.speed = 1;
}


//Player movement
function leftp(px1){
 if(px1 >16){ 
   return px1 = px1 - 8;
     }
 else {return px1;}
}

function rightp(px2){
 if(px2 < 355){ 
   return px2 = px2 + 8;
     }
   else {return px2;} 
}

// AI Movement
function leftAI(px1){
 if(px1 >16){ 
   return px1 = px1 - 8;
     }
 else {
 aip =0;
 return px1;}
}

function rightAI(px2){
 if(px2 < 355){ 
   return px2 = px2 + 8;
     }
   else {
   aip = 1
   return px2;}
}

function lefthmAI(px1, obj){
 if(px1 >16){ // Ã  modfier 
 	if(obj<=px1){
	 return px1 = px1 - 4;
     }
          else {aip = 0;
          return px1;}
     }
 else {aip = 0;
 return px1;}
}

function righthmAI(px2, obj){
 if(px2 <= 355){ 
  	if(obj>=px2){
	 return px2 = px2 + 4;
     }
     else {aip = 1;
     return px2;}
     }
   else {aip = 1;
   return px2;}
  
}
//First AI movement
function movep(){
  if(aip) player1.px = leftAI(player1.px); else player1.px = rightAI(player1.px);
       drawgameboard();
}

//Second AI movement
function movehm(){
if(aip) player1.px = lefthmAI(player1.px, ball.ballx); else player1.px = righthmAI(player1.px, ball.ballx);
       drawgameboard();
}

// 2 players can play
window.addEventListener("keydown", keysPressed, false);
window.addEventListener("keyup", keysReleased, false);
 "C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Servlet/WEB-INF/classes/PongServlet.java"
var keys = [];
 
function keysPressed(e) {
    // store an entry for every key pressed
    keys[e.keyCode] = true;
    var userValue;
    
    userValue = document.getElementById('userValue').value;
    alert(userValue);
   
    if (keys[37] && userValue == "userX") {
       player1.px = leftp(player1.px);
       drawgameboard();
    }
    if (keys[81] && userValue  == "userY") {
       player2.px = leftp(player2.px);
       drawgameboard();
    }
    if (keys[39] && userValue  == "userX") {
       player1.px = rightp(player1.px);
       drawgameboard();
    }
     if (keys[68] && userValue  == "userY") {
       player2.px = rightp(player2.px);
       drawgameboard();
    }    
}
 
function keysReleased(e) {
    // mark keys that were released
    keys[e.keyCode] = false;
}


//permet de bouger le plateau IA
function moveIA(){
if(document.getElementById("checkBox").checked == true){
	clearInterval(ia);
	ia = setInterval(movep,50);
}else{
	clearInterval(ia);
}

}
function moveIAHM(){
if(document.getElementById("checkBoxHM").checked == true){
    clearInterval(ia);
    ia = setInterval(movehm,100);
}else{
	clearInterval(ia);
}
}


//Permet d'arreter le jeu
function gamestop(){
	clearInterval(lancement);
    clearInterval(vit);
}


//Lancement jeu
function gamestart(){
lancement = setInterval(move,20)
}

</script>
</head>
<body>

	<%if(session.getAttribute("username") == null){%>


	Play as player X:
	<form method="post">
		<input type="hidden" id="userX" name="userX" /> Name : <input
			type="text" name="username" /> <input type="submit" value="Play" />
	</form>


	Play as player Y:
	<form method="post">
		<input type="hidden" id="userY" name="userY" /> Name : <input
			type="text" name="username" /> <input type="submit" value="Play" />
	</form>


	<%}else{ %>


	<canvas id="gameboard" width="410" height="410"> This is not supported!</canvas>
	<br />

	<input type="button" value="Start" onclick="gamestart();" />
	<input type="button" value="Stop" onclick="gamestop();" />
	<input type="button" value="testAjax" onclick="valider();" />
	<br /> Statistic
	<table style="width: 50%">
		<tr>
			<td>Yellow wins</td>
			<td><input type="text" id="Resultgreen" value=0
				readonly="readonly"></td>
		</tr>
		<tr>
			<td>Green wins</td>
			<td><input type="text" id="Resultred" value=0
				readonly="readonly"></td>
		</tr>
		<tr>
			<td>X speed</td>
			<td><input type="text" id="speedx" value=0 readonly="readonly"></td>
		</tr>
		<tr>
			<td>Y speed</td>
			<td><input type="text" id="speedy" value=0 readonly="readonly"></td>
		</tr>
		<tr>
			<td>ball speed</td>
			<td><input type="text" id="speedb" value=0 readonly="readonly"></td>
		</tr>
		<tr>
			<td>Computer Yellow</td>
			<td><input id="checkBox" type="checkbox" onclick="moveIA();"></td>
		</tr>

	</table>
	<%}%>
	<input type="hidden" id="userValue" name="userValue"
		value="<%= session.getAttribute("username")%>" />
</body>
</html>