using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using DevExpress.DashboardWeb;
using System.Data.SqlClient;
using System.Data;
using static peptak.SiteMaster;
using System.Web.UI.HtmlControls;

namespace peptak
{
    public partial class _Default : Page
    {
        private string state;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {

                ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());
                ASPxDashboard1.WorkingMode = WorkingMode.Viewer;
                HtmlInputCheckBox toggle = (HtmlInputCheckBox)Master.FindControl("togglebox");


                if (Request.Cookies.Get("state") is null) {
                    Response.Cookies["state"].Value = "light";

                }
                else
                {
                    state = Request.Cookies.Get("state").Value;

                    switch(state)
                    {
                        case "light":
                            ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeLight; 
                            break;
                        case "dark":
                            ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeDarkMoon;
                            break;

                    }
                }


               
            }
           
        }

       

        private void Toggle_CheckedChanged1(object sender, EventArgs e)
        {
            var html = sender as CheckBox;
            var cshecked = html.Checked;
            Response.Write($"<script>alert('Proof+{cshecked}')</script>");

        }

        private void Toggle_ServerChange(object sender, EventArgs e)
        {
            var html = sender as HtmlInputCheckBox;
            var cshecked=html.Checked;
            Response.Write($"<script>alert('Proof+{cshecked}')</script>");
        }

        private void Toggle_CheckedChanged(object sender, EventArgs e)
        {
            Response.Write("<script>alert('Proof')</script>");
        }

        private void ChangeTheme(bool dark)
        {
            if (dark == true)
            {
                ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeDark;
                Session["theme"] = "dark";
            }
            else
            {
                ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeLight;
                Session["theme"] = "light";

            }
        }







        private void CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            Response.Write("<script>testing check</script>");
        }

        protected void cmdSignOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("logon.aspx", true);

        }


       
    }
}