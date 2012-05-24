using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace WindowsFormsApplication_DoTest
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            DataObjects_Framework.Common.Do_Globals.gSettings.pConnectionString = @"User ID=sa; Password=Administrator1; Initial Catalog=Ex;Data Source=.\Sql_2k8;";
            DataObjects_Framework.Common.Do_Globals.gSettings.pUseSoftDelete = false;
            
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
    }
}
