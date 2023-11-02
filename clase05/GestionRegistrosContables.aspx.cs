using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace clase05
{
    public partial class GestionRegistrosContables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCuentasDropdown();
               
                    CargarDatos();

                
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void ButtonCrear_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string insertQuery = "INSERT INTO RegistrosContables (idCuenta, monto, tipo) VALUES (@idCuenta, @monto, @tipo)";
                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@idCuenta", DropDownList2.SelectedValue);
                    cmd.Parameters.AddWithValue("@monto", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@tipo", RadioButtonList1.SelectedValue);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Label2.Text = "Registro contable creado con éxito.";
                        ClearFields();
                    }
                    else
                    {
                        Label2.Text = "Error al crear el registro contable.";
                    }
                }
            }
        }

        protected void ButtonActualizar_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string updateQuery = "UPDATE RegistrosContables SET monto = @monto, tipo = @tipo WHERE idCuenta = @idCuenta";
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@idCuenta", DropDownList2.SelectedValue);
                    cmd.Parameters.AddWithValue("@monto", TextBox1.Text);
                    cmd.Parameters.AddWithValue("@tipo", RadioButtonList1.SelectedValue);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Label2.Text = "Registro contable actualizado con éxito.";
                        ClearFields();
                    }
                    else
                    {
                        Label2.Text = "Error al actualizar el registro contable.";
                    }
                }
            }
        }

        protected void ButtonEliminar_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string deleteQuery = "DELETE FROM RegistrosContables WHERE idCuenta = @idCuenta";
                using (SqlCommand cmd = new SqlCommand(deleteQuery, con))
                {
                    cmd.Parameters.AddWithValue("@idCuenta", DropDownList2.SelectedValue);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        Label2.Text = "Registro contable eliminado con éxito.";
                        ClearFields();
                    }
                    else
                    {
                        Label2.Text = "Error al eliminar el registro contable.";
                    }
                }
            }
        }
        private void CargarDatos()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
            {
                conn.Open();
                string query = "SELECT Cuentas.id, Cuentas.descripcion, RegistrosContables.monto, RegistrosContables.tipo FROM Cuentas INNER JOIN RegistrosContables ON Cuentas.id = RegistrosContables.idCuenta";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }
        private void ClearFields()
        {
            TextBox1.Text = string.Empty;
            RadioButtonList1.ClearSelection();
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int tipo = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "tipo"));

                if (tipo == 1)
                {
                    e.Row.Cells[3].Text = "Haber";
                }
                else
                {
                    e.Row.Cells[3].Text = "Debe";
                }
            }
        }
        private void BindCuentasDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT id, descripcion FROM Cuentas";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    DropDownList2.DataSource = reader;
                    DropDownList2.DataTextField = "descripcion";
                    DropDownList2.DataValueField = "id";
                    DropDownList2.DataBind(); // Agrega esta línea
                }
            }
        }
    }
}
