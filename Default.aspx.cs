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
using System.IO;
using DevExpress.DashboardCommon;
using System.Web.Services;
using System.Web.Script.Serialization;
using Storages;

namespace peptak
{
    public partial class _Default : Page
    {
        private string state;
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxDashboard1.DashboardLoading += ASPxDashboard1_DashboardLoading;
            ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());
       
            ASPxDashboard1.WorkingMode = WorkingMode.Viewer;
            ASPxDashboard1.DashboardAdding += ASPxDashboard1_DashboardAdding;
            ASPxDashboard1.DashboardSaving += ASPxDashboard1_DashboardSaving;
            if (!IsPostBack)
            {

                if (Request.Cookies["dashboard"] is null)
                {

                    ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());
                    ASPxDashboard1.WorkingMode = WorkingMode.Viewer;

                    HtmlInputCheckBox toggle = (HtmlInputCheckBox)Master.FindControl("togglebox");


                    if (Request.Cookies.Get("state") is null)
                    {

                        Response.Cookies["state"].Value = "light";

                    }
                    else
                    {
                        state = Request.Cookies.Get("state").Value;

                        switch (state)
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
                else
                {
                    string id = Request.Cookies["dashboard"].Value;
                    string p = Request.QueryString["p"];
                    
                    if(!String.IsNullOrEmpty(p))
                    {
                        ASPxDashboard1.InitialDashboardId = p;
                    } else {
                        ASPxDashboard1.InitialDashboardId = id;
                    }
                    ASPxDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());
                    ASPxDashboard1.WorkingMode = WorkingMode.Viewer;

                    HtmlInputCheckBox toggle = (HtmlInputCheckBox)Master.FindControl("togglebox");


                    if (Request.Cookies.Get("state") is null)
                    {

                        Response.Cookies["state"].Value = "light";

                    }
                    else
                    {
                        state = Request.Cookies.Get("state").Value;

                        switch (state)
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

            rename();
        }

        private void ASPxDashboard1_DashboardSaving(object sender, DashboardSavingWebEventArgs e)
        {
           // Return control to the front end
        }

        private void ASPxDashboard1_DashboardAdding(object sender, DashboardAddingWebEventArgs e)
        {
       
        }


        [WebMethod]
        public static void DeleteItem(string id)
        {
            string ID = id;
           

        }


        private void ASPxDashboard1_DashboardLoading(object sender, DashboardLoadingWebEventArgs e)
        {
           
            Dashboard dashboard = new Dashboard();
            dashboard.LoadFromXDocument(e.DashboardXml);
            dashboard.DataSources.OfType<DashboardSqlDataSource>().ToList().ForEach(dataSource => {
                dataSource.DataProcessingMode = DataProcessingMode.Client;
            });
            Response.Cookies["dashboard"].Value = e.DashboardId;
            e.DashboardXml = dashboard.SaveToXDocument();
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
        public void rename()
        {
            try
            {
                string name = Request.Cookies["name"].Value.ToString();

                var path = HttpContext.Current.Server.MapPath($"~/App_Data/Dashboards/");
                string old = path + "dashboard1.xml";
                string new_path = path + $"{name}.xml";

                File.Move(old, new_path);
            }
            catch (Exception error)
            {
                var exception = error;
                var stop = 4;
            }
        }
        protected void hiddenButton_Click(object sender, EventArgs e)
        {
           
        }

        protected void ASPxDashboard1_CustomDataCallback(object sender, DevExpress.Web.CustomDataCallbackEventArgs e)
        {
            Dictionary<string, string> parameters = new JavaScriptSerializer().Deserialize<Dictionary<string, string>>(e.Parameter);
            if (!parameters.ContainsKey("ExtensionName"))
                return;

            CustomDashboardFileStorage newDashboardStorage = new CustomDashboardFileStorage(@"~/App_Data/Dashboards");
            if (parameters["ExtensionName"] == "dxdde-delete-dashboard" && parameters.ContainsKey("DashboardID"))
                newDashboardStorage.DeleteDashboard(parameters["DashboardID"]);
        }
    }
}