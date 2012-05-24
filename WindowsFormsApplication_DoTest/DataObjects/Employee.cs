using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataObjects_Framework;
using DataObjects_Framework.Base;
using DataObjects_Framework.Common;

namespace WindowsFormsApplication_DoTest.DataObjects
{
    public class Employee : Entity
    {
        Employee_Salary mObj_ES;

        public Employee(Object User = null)
        {
            this.Setup(
                "Employee"
                , ""
                , User
                , new List<string>() { "ID" });

            //this.Add_TableDetail(
            //    "Employee_Salary"
            //    , ""
            //    , ""
            //    , new List<string>() { "ID" }
            //    , new List<Do_Constants.Str_ForeignKeyRelation>() 
            //        { new Do_Constants.Str_ForeignKeyRelation() 
            //            { Parent_Key = "ID", Child_Key = "ID_Employee" } });
        }

        public override void Load(DataObjects_Framework.Objects.ClsKeys Keys = null)
        {
            base.Load(Keys);
        }

        public System.Data.DataTable pSalary
        {
            get { return this.pTableDetail_Get("Employee_Salary"); }
        }

    }
}
