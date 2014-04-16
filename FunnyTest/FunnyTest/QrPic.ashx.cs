using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using ZXing;
using ZXing.QrCode;

namespace FunnyTest
{
    /// <summary>
    /// QrPic 的摘要描述
    /// </summary>
    public class QrPic : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            //var strUri = string.Format("http://{0}:{1}{2}{3}?strId={4}",
            //    context.Request.Url.Host,
            //    context.Request.Url.Port,
            //    context.Request.ApplicationPath,
            //    "/OperatorClient.aspx",
            //    context.Request["strId"].ToString());

            //var strUri = @"http://"+context.Request.+"/FunnyTest/OperatorClient.aspx?strId=" + context.Request["strId"].ToString();
            var strUri = string.Format(@"http://{0}:{1}/{2}/OperatorClient.aspx?strId={3}",
                context.Request.ServerVariables["LOCAL_ADDR"],
                context.Request.Url.Port,
                context.Request.Url.Segments[1].Replace("/", ""),
                context.Request["strId"].ToString()
                );
            var qrWriter = new BarcodeWriter()
            {
                Format = BarcodeFormat.QR_CODE,
                Options = new QrCodeEncodingOptions
                {
                    Height = 225,
                    Width = 225
                }
            };

            var bmp = qrWriter.Write(strUri.Replace("127.0.0.1","stan-nb"));
            context.Response.ContentType = "text/plain";
            bmp.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);



        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}