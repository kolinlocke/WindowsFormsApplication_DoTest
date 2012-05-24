using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication_DoTest
{
    public partial class Form1 : Form
    {
        DataObjects.Employee Employee;

        public Form1()
        {
            InitializeComponent();

            this.Load += new EventHandler(Form1_Load);
            this.dataGridView1.DoubleClick += new EventHandler(dataGridView1_DoubleClick);
        }

        void dataGridView1_DoubleClick(object sender, EventArgs e)
        {
            DataRow Dr = (this.dataGridView1.CurrentRow.DataBoundItem as DataRowView).Row;
            Form2 Frm = new Form2(this.Employee.GetKeys(Dr));
            Frm.Ev_Saved += Frm_Ev_Saved;
            Frm.Show(this);
        }

        void Frm_Ev_Saved()
        {
            this.Form1_Load(null, null);
        }

        void Form1_Load(object sender, EventArgs e)
        {
            this.Employee = new DataObjects.Employee();
            this.dataGridView1.DataSource = this.Employee.List();
            this.dataGridView1.AutoGenerateColumns = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form2 Frm = new Form2(null);
            Frm.Ev_Saved += Frm_Ev_Saved;
            Frm.Show(this);
        }
    }
}
