using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using DevExpress.DashboardWeb;
using DevExpress.Web;
using Storages;

namespace peptak
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            CustomDashboardFileStorage newDashboardStorage = new CustomDashboardFileStorage(@"~/App_Data/Dashboards");
            DashboardConfigurator.Default.SetDashboardStorage(newDashboardStorage);

            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            ASPxWebControl.CallbackError += Application_Error;
        }


        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exception = HttpContext.Current.Server.GetLastError();
            var stop = true;
        }
    }
}