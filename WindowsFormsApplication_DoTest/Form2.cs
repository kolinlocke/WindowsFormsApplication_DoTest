using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using DataObjects_Framework;
using DataObjects_Framework.Objects;
using DataObjects_Framework.Common;

namespace WindowsFormsApplication_DoTest
{
    public partial class Form2 : Form
    {
        public delegate void Ds_Generic();
        public event Ds_Generic Ev_Saved;

        DataObjects.Employee Employee;

        public Form2(ClsKeys Key)
        {
            InitializeComponent();
            this.Load += new EventHandler(Form2_Load);
            this.Btn_Save.Click += new EventHandler(Btn_Save_Click);

            this.Employee = new DataObjects.Employee(null);
            this.Employee.Load(Key);
        }

        void Btn_Save_Click(object sender, EventArgs e)
        {
            //this.Employee.pDr["Name"] = this.Txt_Name.Text;
            //this.Employee.pDr["Code"] = this.Txt_Code.Text;

            this.Employee.Save();
            if (this.Ev_Saved != null)
            { this.Ev_Saved(); }
        }

        void Form2_Load(object sender, EventArgs e)
        {
            this.Txt_Name.DataBindings.Add("Text", this.Employee.pDr.Table, "Name");
            this.Txt_Code.DataBindings.Add("Text", this.Employee.pDr.Table, "Code");
                        
            this.Grid_Salary.DataSource = this.Employee.pSalary;
            this.Grid_Salary.AutoGenerateColumns = true;

            
            //this.Txt_Name.Text = DataObjects_Framework.Common.Do_Methods.Convert_String(this.Employee.pDr["Name"]);
            //this.Txt_Code.Text = Do_Methods.Convert_String(this.Employee.pDr["Code"]);
            
        }

    }
}

