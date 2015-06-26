﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OperatorClient.aspx.cs" Inherits="FunnyTest.OperatorClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<div class="row">
    <div class=" col-xs-8">
<table>
            <tr>
                <td>
                </td>
                <td>
                    <img alt="" id="imgUp" src="images/up1.png" /></td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <img alt="" id="imgLeft" src="images/left1.png" /></td>
                <td></td>
                <td><img alt="" id="imgRight" src="images/right1.png" /></td>
            </tr>
            <tr>
                <td></td>
                <td><img alt="" id="imgDown" src="images/down1.png" /></td>
                <td></td>
            </tr>
        </table>
    </div>
</div>
 <div class="row">

     <div class="col-xs-8">
         <table>
    <tr>
        <td>
            <span id="msLogin"></span>
        </td>
    </tr>
    <tr>
        <td>
            <button id="btnOfffLine" class="btn btn-danger"><i class=" icon-ban-circle"></i>斷線</button>
                <%--<input id="btnOfffLine" type="button" value="斷線" />--%>
        </td>
    </tr>
</table>
     </div>
 </div>       

        <input id="hId" type="hidden" />
    </form>
    <!--Reference the jQuery library. -->
    <script src="Scripts/jquery-2.1.0.min.js"></script>
    <script src="Scripts/jquery-2.1.0.intellisense.js"></script>
    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.0.3.min.js"></script>
    <script src="Scripts/jquery.url.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>

    <script type="text/javascript">
        $(function () {
            var gid;
            var fHub = $.connection.FunnyHub;
            $("#imgUp").click(function () {
                fHub.server.ChangeHostDirection("client_" + $("#hId").val(), "host_" + $("#hId").val(), "Up");
            });
            $("#imgDown").click(function () {
                fHub.server.ChangeHostDirection("client_" + $("#hId").val(), "host_" + $("#hId").val(), "Down");
            });
            $("#imgLeft").click(function () {
                fHub.server.ChangeHostDirection("client_" + $("#hId").val(), "host_" + $("#hId").val(), "Left");
            });
            $("#imgRight").click(function () {
                fHub.server.ChangeHostDirection("client_" + $("#hId").val(), "host_" + $("#hId").val(), "Right");
            });



            //進行斷線
            fHub.client.closeConnection = function () {
                $.connection.hub.stop();
            };

            //已經斷線
            $.connection.hub.disconnected(function () {
                document.title = "失去連線";
                alert("已失去連線！！！");
            });

            //開啟連線
            $.connection.hub.start().done(function () {
                //建立斷線按鈕的event handler
                $("#btnOfffLine").click(function () {
                    fHub.server.OffLine("client_" + $("#hId").val(), "host_" + $("#hId").val());
                });
                //var gid = "Client_" + "<%=Guid.NewGuid() %>";
                gid = $.url.param("strId");
                $("#hId").val(gid);
                fHub.server.UserConnected("client_" + gid);

            });
        });
    </script>
</body>
</html>
