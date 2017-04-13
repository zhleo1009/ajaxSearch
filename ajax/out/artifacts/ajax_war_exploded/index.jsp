<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-04-12
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>IDEA创建的WEB项目</title>
    <style type="text/css">
      #mydiv{
        position: absolute;
        left: 50%;
        top:50%;
        margin-left: -200px;
        margin-top: -50px;
      }
      .mouseOver{
        background: #708090;
        color: #FFFAFA;
      }
      .mouseOut{
        background: #FFFAFA;
        color: #000000;
      }
    </style>
    <script type="text/javascript">

      var xmlHttp ;
        //获取用户输入内容的关联信息的函数
      function getMoreContents() {
          //s首先获取用户的输入
          var content = document.getElementById("keyword");
          if (content.value==""){
              clearContent();
              return;
          }
          //然后给服务器发送用户输入的内容,因为采用ajax异步发送数据,
          //所以使用XmlHttp对象
          xmlHttp = creatXMLHttp();
          //给服务器发送数据
          var url = "search?keyword="+escape(content.value);
          xmlHttp.open("GET",url,true);
          //xmlHttp绑定回调方法
          //xmlHttp 状态0-4,我们只关心4(complete)
          xmlHttp.onreadystatechange=callback;
          xmlHttp.send(null);



      }
      //获取XmlHttp对象
      function creatXMLHttp(){
          var xmlHttp;
          if (window.XMLHttpRequest){
              xmlHttp=new XMLHttpRequest();
          }
          if(window.ActiveXObject){
              xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
              if(!xmlHttp){
                  xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
              }
          }
          return xmlHttp;
      }

      //回调函数
      function callback() {
          //4代表成功
          if(xmlHttp.readyState == 4){
              //200代表服务器响应成功
              if(xmlHttp.status == 200){
                  //交互成功 获得响应的数据 是文本格式
                  var result = xmlHttp.responseText;
                  //解析数据
                  var json = eval("("+result+")");
                  //获取数据后动态显示 展示输入框下面
                setContent(json);

              }
          }
      }
      //设置关联数据展示
      function setContent(contents) {
          clearContent();
          setLocation();
          //获取关联数据的长度,以此来确定生成的<tr>
          var size = contents.length;
          //设置内容
          for(var i=0;i<size;i++){
              var nextNode = contents[i];
              var tr = document.createElement("tr");
              var td = document.createElement("td");
              td.setAttribute("border","0");
              td.setAttribute("bgcolor","#FFFAFA");
              td.onmouseover=function () {
                  this.className = 'mouseOver';
              };
              td.onmouseout=function () {
                  this.className = 'mouseOut';
              };
              td.onclick=function () {

              };
              var text = document.createTextNode(nextNode);
              td.appendChild(text);
              tr.appendChild(td);
              document.getElementById("content_table_body").appendChild(tr);
          }


      }
      //清空之前的数据
      function clearContent() {
          var contentTableBody = document.getElementById("content_table_body");
          var size = contentTableBody.childNodes.length;
          for(var i=size-1;i>=0;i--){
              contentTableBody.removeChild(contentTableBody.childNodes[i]);
          }
          document.getElementById("popdiv").style.border="none";
      }

      //输入框失去焦点 清空
      function keywordBlur() {
          clearContent();
      }
      //设置系那是关联信息
      function setLocation() {
          //关联信息的显示位置
          var content = document.getElementById("keyword");
          var width = content.offsetWidth;//输入框的宽度
          var left = content["offsetLeft"];//距离左边框的距离
          var top = content["offsetTop"]+content.offsetHeight;//距离顶部
          //获取显示数据div
          var popdiv = document.getElementById("popdiv");
          popdiv.style.border="black 1px solid";
          popdiv.style.left=left+"px";
          popdiv.style.top = top+"px";
          popdiv.style.width = width+"px";
          document.getElementById("content_table").style.width = width+ "px";



      }
    </script>
  </head>
  <body>
   <div id="mydiv">
     <!--输入框-->
     <input type="text" size="50" id="keyword" onkeyup="getMoreContents()"
     onblur="keywordBlur()" onfocus="getMoreContents()"/>
     <input type="button" value="百度一下" width="50px">
     <%--内容展示区域--%>
     <div id="popdiv">
       <table id="content_table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0">
         <tbody id="content_table_body">
         <%--动态查询出来的数据,显示在此--%>

         </tbody>
       </table>

     </div>

   </div>

  </body>
</html>
