using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Infrastructure;
using Microsoft.Owin;
using Owin;
[assembly: OwinStartup(typeof(FunnyTest.Startup))]

namespace FunnyTest
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //var idProvider = new CustomUserIdProvider();
            //GlobalHost.DependencyResolver.Register(typeof(IUserIdProvider), () => idProvider); 
            app.MapSignalR();


        }
    }
}