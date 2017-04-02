using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using AIMLbot;

namespace ChatBotApp
{
    public partial class Default : System.Web.UI.Page
    {
        Acutus acutus;

        protected void Page_Load(object sender, EventArgs e)
        {
            String input;

            if ((input = Request.QueryString["msg"]) != null)
            {
                string path = Server.MapPath("~");
                acutus = new Acutus(path);

                String output;

                if((output = acutus.GetOutput(input.ToUpper())) != null)
                {
                    Response.Write(output);
                }
                
            }

        }
    }
}