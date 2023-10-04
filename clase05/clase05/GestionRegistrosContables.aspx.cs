using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace clase05
{
    public partial class GestionRegistrosContables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                completarTabla();
            }

        }

        protected void completarTabla()
        {
            try
            {
                DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);

                if (dv != null && dv.Count > 0)
                {
                    //Rellenar cabecera
                    TableRow headerRow = new TableRow();

                    TableCell headerCell1 = new TableCell();
                    headerCell1.Text = "Monto";
                    headerRow.Cells.Add(headerCell1);

                    TableCell headerCell2 = new TableCell();
                    headerCell2.Text = "Cuenta";
                    headerRow.Cells.Add(headerCell2);

                    TableCell headerCell3 = new TableCell();
                    headerCell3.Text = "Tipó";
                    headerRow.Cells.Add(headerCell3);

                    Table1.Rows.Add(headerRow);

                    // Rellenar las filas
                    foreach (DataRowView rowView in dv)
                    {
                        DataRow row = rowView.Row;
                        TableRow tableRow = new TableRow();

                        TableCell Cell1 = new TableCell();
                        Cell1.Text = row["monto"].ToString();
                        tableRow.Cells.Add(Cell1);

                        TableCell Cell2 = new TableCell();
                        Cell2.Text = row["descripcion"].ToString();
                        tableRow.Cells.Add(Cell2);

                        TableCell Cell3 = new TableCell();
                        Cell3.Text = row["tipo"].ToString();
                        tableRow.Cells.Add(Cell3);

                        Table1.Rows.Add(tableRow);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AletScript", $"alert('Error');", true);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource2.Insert();
            if(result > 0)
            {
                Label1.Text = "Agregado " + result.ToString() + " registro.";
                completarTabla();
                TextBox1.Text = string.Empty; TextBox2.Text = string.Empty;
            }
            else
            {
                Label1.Text = "No se agregaron registros.";
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource2.Delete();
            if (result > 0)
            {
                Label1.Text = "Elimnado " + result.ToString() + " registro.";
                completarTabla();
                TextBox1.Text = string.Empty; TextBox2.Text = string.Empty;
            }
            else
            {
                Label1.Text = "No se eliminaron registros.";
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            if(dv != null && dv.Count > 0)
            {
                DataRowView row = dv[0];
                TextBox1.Text = row["monto"].ToString();
                DropDownList1.SelectedValue = row["idCuenta"].ToString();
                TextBox2.Text = row["tipo"].ToString();
            }
            completarTabla();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource2.Update();
            if (result > 0)
            {
                Label1.Text = "Modificado " + result.ToString() + " registro.";
                completarTabla();
                TextBox1.Text = string.Empty; TextBox2.Text = string.Empty;
            }
            else
            {
                Label1.Text = "No se modificaron registros.";
            }
        }
    }
}