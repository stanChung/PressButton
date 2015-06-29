﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DisplayHost.aspx.cs" Inherits="FunnyTest.DisplayHost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class=" main panel panel-default">
            <div class=" row">
                <div class="col-md-6">
                    <table>
                        <tr>
                            <td></td>
                            <td>
                                <img alt="" id="imgUp" src="images/up2.png" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <img alt="" id="imgLeft" src="images/left2.png" /></td>
                            <td></td>
                            <td>
                                <img alt="" id="imgRight" src="images/right2.png" /></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <img alt="" id="imgDown" src="images/down2.png" /></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <textarea id="stHistory" style="width:100%" rows="6" cols="50">
                                    </textarea>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-4">
                    <div class="row">
                        <p class=" text-success">
                            <i class="icon-info"></i>歡迎來到
                        「上上下下左左右右」
                        </p>
                        <p class="text-muted">
                            請以您的手機<i class="icon-mobile-phone icon-2x"></i>或其它行動裝置讀取以下QR Code！
                        </p>
                        <hr />
                    </div>

                    <div class="row">
                        <table>
                            <tr>
                                <td>
                                    <a id="linkGo">
                                        <img alt="" id="imgQrCode" src="" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </div>

                </div>
            </div>

        </div>

        <div id="modauMessage" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">Modal title</h4>
                    </div>
                    <div id="modalbody" class="modal-body">
                        <p>One fine body&hellip;</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->


    </form>

    <!--Script references. -->
    <!--Reference the jQuery library. -->
    <script src="Scripts/jquery-2.1.0.min.js"></script>
    <%--<script src="Scripts/jquery-2.1.0.intellisense.js"></script>--%>
    <!--Reference the SignalR library. -->
    <script src="Scripts/jquery.signalR-2.0.3.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="signalr/hubs"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>

    <script type="text/javascript">


        $(function () {


            $("#imgUp").css("visibility", "hidden");
            $("#imgDown").css("visibility", "hidden");
            $("#imgLeft").css("visibility", "hidden");
            $("#imgRight").css("visibility", "hidden");


            var fHub = $.connection.FunnyHub;
            //依據指令來改變圖片的顯示
            fHub.client.changeDirecttoHost = function (direct) {

                $("#imgUp").css("visibility", "hidden");
                $("#imgDown").css("visibility", "hidden");
                $("#imgLeft").css("visibility", "hidden");
                $("#imgRight").css("visibility", "hidden");

                $("#img" + direct).css("visibility", "display");

                //加按鈕記錄
                var now=new Date();
                //$("#stHistory").append($("<option></option>").attr("value", direct).text("you press " + direct + now.format("yyyy/MM/dd hh:mm tt")));
                var history= $("#stHistory").text()+"\r"+"You Press "+direct+" "+now.format("yyyy/MM/dd hh:mm tt") + '</option>');
                $("#stHistory").text(history);    
                //.append('<option value="' + direct + '">You press ' + direct + ' ' + now.format("yyyy/MM/dd hh:mm tt") + '</option>');
            };

            //進行斷線
            fHub.client.closeConnection = function () {
                $.connection.hub.stop();
            };


            //已經斷線
            $.connection.hub.disconnected(function () {
                document.title = "失去連線";
                showMessage("失去連線");
                location.reload();
                //alert("已失去連線！！！");
            });

            //開啟連線
            $.connection.hub.start().done(function () {

                var gid = "<%=Guid.NewGuid() %>";
                //var gid = "host";
                document.title = "";
                $("#hId").val("host_" + gid);
                var uri = "<%=getUrl()%>/QrPic.ashx?strId=" + gid;
                $("#imgQrCode").attr("src", uri);
                $("#linkGo").attr("href", "<%=getUrl()%>/OperatorClient.aspx?strId=" + gid);
                fHub.server.UserConnected("host_" + gid);

            });


            //modal
            var OptMessage = {
                show:false
            };
            $('#modauMessage').modal(OptMessage);

        });

        //顯示訊息
        function showMessage(message)
        {
            var msg = "<p>" + message + "</p>";
            $("#modalbody").html(msg);
            $('#modauMessage').modal('show');
        }
    </script>

</body>
</html>
