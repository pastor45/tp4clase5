using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CuentasContablesTp3
{
    public partial class GestionRegistrosContables : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatos();
                CargarCuentasEnDropDownList();

            }
        }
        private void CargarCuentasEnDropDownList()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
            {
                conn.Open();
                string query = "SELECT id, descripcion FROM Cuentas";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        DropDownList1.DataSource = dt;
                        DropDownList1.DataTextField = "descripcion";
                        DropDownList1.DataValueField = "id";
                        DropDownList1.DataBind();
                    }
                }
                // Agrega un elemento vacío si lo deseas
                DropDownList1.Items.Insert(0, new ListItem("Seleccione una cuenta", string.Empty));
            }
        }
        private void CargarDatos()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
            {
                conn.Open();
                string query = "SELECT RegistrosContables.id AS RegistroID, Cuentas.id AS CuentaID, Cuentas.descripcion, RegistrosContables.monto, RegistrosContables.tipo FROM Cuentas INNER JOIN RegistrosContables ON Cuentas.id = RegistrosContables.idCuenta";
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

        protected void btnAgregarRegistro_Click(object sender, EventArgs e)
        {
            try
            {
                int idCuenta = Convert.ToInt32(DropDownList1.SelectedValue);
                int monto = Convert.ToInt32(TextBox1.Text);
                bool tipo = Convert.ToInt32(RadioButtonListTipo.SelectedValue) == 1; // 1 representa "Haber", 0 representa "Debe"

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
                {
                    con.Open();
                    string query = "INSERT INTO [RegistrosContables] (idCuenta, monto, tipo) VALUES (@idCuenta, @monto, @tipo)";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@idCuenta", idCuenta);
                        cmd.Parameters.AddWithValue("@monto", monto);
                        cmd.Parameters.AddWithValue("@tipo", tipo);
                        cmd.ExecuteNonQuery();
                    }
                }

                CargarDatos();
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }


        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            CargarDatos();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int registroID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                DropDownList ddlEditCuenta = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlEditCuenta");
                int idCuenta = Convert.ToInt32(ddlEditCuenta.SelectedValue);

                TextBox txtEditMonto = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditMonto");
                int monto = Convert.ToInt32(txtEditMonto.Text);

                RadioButton rbEditIngreso = (RadioButton)GridView1.Rows[e.RowIndex].FindControl("rbEditIngreso");
                bool tipo = rbEditIngreso.Checked;

                byte tipoBit = tipo ? (byte)1 : (byte)0;

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
                {
                    con.Open();
                    string query = "UPDATE [RegistrosContables] SET idCuenta = @idCuenta, monto = @monto, tipo = @tipo WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@id", registroID);
                        cmd.Parameters.AddWithValue("@idCuenta", idCuenta);
                        cmd.Parameters.AddWithValue("@monto", monto);
                        cmd.Parameters.AddWithValue("@tipo", tipoBit); 
                        cmd.ExecuteNonQuery();
                    }
                }

                GridView1.EditIndex = -1;
                CargarDatos();
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }


        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            CargarDatos();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cadena"].ConnectionString))
                {
                    con.Open();
                    string query = "DELETE FROM [RegistrosContables] WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                    }
                }

                CargarDatos();
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }
    }
}
