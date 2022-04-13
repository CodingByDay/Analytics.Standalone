using DevExpress.DashboardCommon;
using DevExpress.DashboardWeb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace peptak
{
    public partial class MobileDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            ASPxWebDashboard1.SetConnectionStringsProvider(new DevExpress.DataAccess.Web.ConfigFileConnectionStringsProvider());
            ASPxWebDashboard1.WorkingMode = WorkingMode.Viewer;
           // DashboardInMemoryStorage dashboardStorage = Session["DashboardStorage"] as DashboardInMemoryStorage;
            // Uncomment this line to use the App_Data/Dashboards folder to store dashboards.
            DashboardFileStorage dashboardStorage = new DashboardFileStorage(@"~/App_Data/Dashboards");
            ASPxWebDashboard1.SetDashboardStorage(dashboardStorage);
        }

        private void ASPxDashboard_CallbackError(object sender, EventArgs e)
        {
            var s = e.ToString();
            var debug = true;
        }

      

        protected void OnDataLoading(object sender, DevExpress.DashboardWeb.DataLoadingWebEventArgs e)
        {
         //   DashboardMainDemo.DataLoader.LoadData(e);
        }

        protected void OnDashboardLoading(object sender, DashboardLoadingWebEventArgs e)
        {
           
        }
    }
}