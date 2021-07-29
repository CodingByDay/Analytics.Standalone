using System.Collections.Generic;
using System.Data;
using System;
using DevExpress.Utils;
using System.IO;
using System.Web.Hosting;
using System.Configuration;
using DevExpress.DashboardWeb;

namespace DashboardMainDemo
{
    public static class DataLoader
    {
        static string GetRelativePath(string name)
        {
            return Path.Combine(HostingEnvironment.MapPath("~"), "App_Data", "Data", name);
        }
        static DataSet LoadData(string fileName)
        {
            string path = GetRelativePath(string.Format("{0}.xml", fileName));
            DataSet ds = new DataSet();
            ds.ReadXml(path, XmlReadMode.ReadSchema);
            return ds;
        }
        public static DataSet LoadSales()
        {
            return LoadData("DashboardSales");
        }
        public static DataSet LoadEmployees()
        {
            return LoadData("DashboardEmployeesAndDepartments");
        }
        public static DataSet LoadCustomerSupport()
        {
            return LoadData("DashboardCustomerSupport");
        }
        public static DataSet LoadRevenueByIndustry()
        {
            return LoadData("DashboardRevenueByIndustry");
        }
        public static DataSet LoadEuroEnergyStatistics()
        {
            return LoadData("DashboardEnergyStatictics");
        }
        public static DataSet LoadEnergyConsumptionTotal()
        {
            return LoadData("DashboardEnergyConsumptionTotal");
        }
        public static DataSet LoadEnergyConsumptionBySector()
        {
            return LoadData("DashboardEnergyConsumptionBySector");
        }
        public static string GetImagesFolder()
        {
            return GetRelativePath("ProductDetailsImages");
        }

        public static void LoadData(DataLoadingWebEventArgs e)
        {
          
        }
    }
}
