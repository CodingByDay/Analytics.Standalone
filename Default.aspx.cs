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
namespace peptak
{
    public partial class _Default : Page
    {
        private SqlConnection conn;
        private SqlCommand cmd;
        private string userRole;
        private object userName;

        protected void Page_Load(object sender, EventArgs e)
        {

            //if (!IsPostBack)
            //{




                ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());


                ASPxDashboard1.WorkingMode = WorkingMode.Viewer;

            //    Button button = (Button)Master.FindControl("themeButton");
            //    button.Click += Button_Click;
            //} else
            //{
            //    if(Session["theme"].ToString() == "dark")
            //    {

            //        ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());


            //        ASPxDashboard1.WorkingMode = WorkingMode.Viewer;
            //        ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeDark;

            //        Button button = (Button)Master.FindControl("themeButton");
            //        button.Click += Button_Click;
            //    } else
            //    {

            //        ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());


            //        ASPxDashboard1.WorkingMode = WorkingMode.Viewer;
            //        ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeLight;

            //        Button button = (Button)Master.FindControl("themeButton");
            //        button.Click += Button_Click;
            //    }
          //  }
        }
        //private void ChangeTheme(bool dark)
        //{
        //    if (dark == true)
        //    {
        //        ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeDark;
        //        Session["theme"] = "dark";
        //    }
        //    else
        //    {
        //        ASPxDashboard1.ColorScheme = ASPxDashboard.ColorSchemeLight;
        //        Session["theme"] = "light";

        //    }
        //}


        //private void Button_Click(object sender, EventArgs e)
        //{
        //    Button button = sender as Button;

        //    if (button.Text == "Temno")
        //    {
        //        button.Text = "Svetlo";
        //        ChangeTheme(false);

        //    }
        //    else
        //    {
        //        button.Text = "Temno";
        //        ChangeTheme(true);

        //    }
        //}
    

       

        //private void CheckBox_CheckedChanged(object sender, EventArgs e)
        //{
        //    Response.Write("<script>testing check</script>");
        //}

        protected void cmdSignOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("logon.aspx", true);

        }


       
    }
}