using System.Collections.Generic;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using System.Linq;
using System.Threading.Tasks;
using System;

namespace FunnyTest
{
    [HubName("FunnyHub")]
    public class FunnyHub : Hub
    {


        [HubMethodName("UserConnected")]
        public void UserConnected(string name)
        {
            UserHandler.ConnectedIds.Add(Context.ConnectionId,name);

        }


        public override Task OnDisconnected()
        {
            // 當使用者離開時，移除在清單內的 ConnectionId
            Clients.All.removeList(Context.ConnectionId);
            UserHandler.ConnectedIds.Remove(Context.ConnectionId);
            return base.OnDisconnected();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="name"></param>
        /// <param name="direct"></param>
        [HubMethodName("ChangeHostDirection")]
        public void ChangeHostDirection(string name,string toname, string direct)
        {
            var fromId = UserHandler.ConnectedIds.Where(p => p.Value == name).FirstOrDefault().Key;
            var toId = UserHandler.ConnectedIds.Where(p => p.Value == toname).FirstOrDefault().Key;

            Clients.Client(toId).changeDirecttoHost(direct);
        }

        /// <summary>
        /// 離線動作
        /// </summary>
        /// <param name="clientName">clent名稱</param>
        /// <param name="hostName">host名稱</param>
        [HubMethodName("OffLine")]
        public void OffLine(string clientName,string hostName)
        {

            var clientId = UserHandler.ConnectedIds.Where(p => p.Value == clientName).FirstOrDefault().Key;
            var hostId = UserHandler.ConnectedIds.Where(p => p.Value == hostName).FirstOrDefault().Key;

            //斷host
            Clients.Client(hostId).closeConnection();
            //斷client
            Clients.Client(clientId).closeConnection();
            
        }
    }



    /// <summary>
    /// 使用者
    /// </summary>
    public static class UserHandler
    {
        public static Dictionary<string, string> ConnectedIds = new Dictionary<string, string>();
    }
}