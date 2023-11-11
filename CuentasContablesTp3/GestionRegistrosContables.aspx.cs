using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CuentasContablesTp3
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
                DataView dv = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);

                if (dv != null && dv.Count > 0)
                {
                    // Rellenar cabecera
                    TableRow headerRow = new TableRow();

                    TableCell headerCell1 = new TableCell();
                    headerCell1.Text = "ID";
                    headerRow.Cells.Add(headerCell1);

                    TableCell headerCell2 = new TableCell();
                    headerCell2.Text = "Cuenta";
                    headerRow.Cells.Add(headerCell2);

                    TableCell headerCell3 = new TableCell();
                    headerCell3.Text = "Monto";
                    headerRow.Cells.Add(headerCell3);

                    TableCell headerCell4 = new TableCell();
                    headerCell4.Text = "Tipo";
                    headerRow.Cells.Add(headerCell4);

                    Table1.Rows.Add(headerRow);

                    // Rellenar las filas
                    foreach (DataRowView rowView in dv)
                    {
                        DataRow row = rowView.Row;
                        TableRow tableRow = new TableRow();

                        // Agregar la nueva celda para el ID
                        TableCell cell0 = new TableCell();
                        cell0.Text = row["id"].ToString();
                        tableRow.Cells.Add(cell0);

                        TableCell cell1 = new TableCell();
                        cell1.Text = row["descripcion"].ToString();
                        tableRow.Cells.Add(cell1);

                        TableCell cell2 = new TableCell();
                        cell2.Text = row["monto"].ToString();
                        tableRow.Cells.Add(cell2);

                        TableCell cell3 = new TableCell();
                        cell3.Text = row["tipo"].ToString();
                        tableRow.Cells.Add(cell3);

                        Table1.Rows.Add(tableRow);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", $"alert('Error');", true);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource2.Insert();
            if(result > 0)
            {
                Label1.Text = "Se agrego " + result.ToString() + " registro";
                completarTabla();
                TextBox1.Text = string.Empty;
            }
            else
            {
                Label1.Text = "No se agregaron registros";
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource2.Delete();
            if (result > 0)
            {
                Label1.Text = "Se elimino " + result.ToString() + " registro";
                completarTabla();
                TextBox1.Text = string.Empty;
            }
            else
            {
                Label1.Text = "No se eliminaron registros";
            }
        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataView dv = (DataView)SqlDataSource4.Select(DataSourceSelectArguments.Empty);
            if(dv != null && dv.Count > 0)
            {
                DataRowView row = dv[0];
                TextBox1.Text = row["monto"].ToString();
                DropDownList1.SelectedValue = row["idCuenta"].ToString();

                //verificar si el valor existe en DropDownList2 antes de asignarlo
                string tipoValue = row["tipo"].ToString();
                if (DropDownList2.Items.FindByValue(tipoValue) != null)
                {
                    DropDownList2.SelectedValue = tipoValue;
                }
            }
            completarTabla();  
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            int result = SqlDataSource2.Update();
            if (result > 0)
            {
                Label1.Text = "Se Actualizo " + result.ToString() + " registro";
                completarTabla();
                TextBox1.Text = string.Empty;
            }
            else
            {
                Label1.Text = "No se actualizaron registros";
            }
        }
    }
}