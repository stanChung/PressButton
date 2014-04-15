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
            return string.Format(@"http://{0}:{1}/{2}/",
                Request.ServerVariables["LOCAL_ADDR"],
                Request.Url.Port,
                Request.Url.Segments[1].Replace("/", "")
                );
        }
    }
}