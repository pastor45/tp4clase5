using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace clase05
{
    public partial class GestionCuentas : System.Web.UI.Page
    {
     
        protected void Page_Load(object sender, EventArgs e)
        {
           


        }

      

        protected void Button1_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource1.Insert();
            if(result != 0)
            {
                Label1.Text = "Se ha agregado "+ result.ToString() + " registros";
                TextBox1.Text = "";
            }
            else
            {
                Label1.Text = " No se agregaron registros";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource1.Delete();

            if (result != 0)
            {
                Label1.Text = "Se ha eliminado " + result.ToString() + " registros";
                TextBox2.Text = "";
            }
            else
            {
                Label1.Text = "No se eliminaron registros";
            }
        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlDataSource2.DataSourceMode = SqlDataSourceMode.DataReader;
            SqlDataReader reader = (SqlDataReader)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            if(reader.Read())
            {
                TextBox2.Text = reader["descripcion"].ToString();
            }
        }

      

        protected void Button3_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource1.Update();
            if (result != 0)
            {
                Label1.Text = "Se ha modificado " + result.ToString() + " registros";
                TextBox2.Text = "";
            }
            else
            {
                Label1.Text = " No se modificaron registros";
            }
        }
    }
}