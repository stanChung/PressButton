using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FunnyTest
{
    public partial class DisplayHost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string getUrl()
        {
            
#if !Release
            var strURL = "http://" + Request.Url.Host + ":" + Request.Url.Port +
                (Request.ApplicationPath.EndsWith("/") ? string.Empty : Request.ApplicationPath);
#else
            var strURL = "http://" + Request.Url.Host  +
                (Request.ApplicationPath.EndsWith("/") ? string.Empty : Request.ApplicationPath);
#endif
            return strURL;
        }
    }
}