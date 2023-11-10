<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionRegistrosContables.aspx.cs" Inherits="CuentasContablesTp3.GestionRegistrosContables" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestión de Registros Contables</title>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        form {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #HyperLink1 {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
        }

        #DropDownList1,
        #TextBox1 {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
        }

        #btnAgregarRegistro {
            background-color: #2ecc71;
            color: #fff;
            padding: 10px;
            border: none;
            cursor: pointer;
        }

        #GridView1 {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        #GridView1 th,
        #GridView1 td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        #GridView1 th {
            background-color: #3498db;
            color: #fff;
        }

        #GridView1 tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        #GridView1 tr:hover {
            background-color: #e0e0e0;
        }

        #GridView1 input[type="text"] {
            width: 80px;
            padding: 5px;
            box-sizing: border-box;
        }

        #GridView1 input[type="radio"] {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Index.aspx">Menu</asp:HyperLink>
            <br />
<asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True">
</asp:DropDownList>

<asp:TextBox ID="TextBox1" runat="server" Placeholder="Monto"></asp:TextBox>
            <br />
            <asp:RadioButtonList ID="RadioButtonListTipo" runat="server">
                <asp:ListItem Text="Debe" Value="0" />
                <asp:ListItem Text="Haber" Value="1" />
            </asp:RadioButtonList>
            <br />
            <asp:Button ID="btnAgregarRegistro" runat="server" Text="Agregar Registro" OnClick="btnAgregarRegistro_Click" />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="RegistroID"
    OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit"
    OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting">
    <Columns>
        <asp:BoundField DataField="RegistroID" HeaderText="ID" ReadOnly="True" SortExpression="RegistroID" />
        <asp:TemplateField HeaderText="Cuenta">
            <ItemTemplate>
                <%# Eval("descripcion") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="ddlEditCuenta" runat="server" DataSourceID="SqlDataSourceCuentas"
                    DataTextField="descripcion" DataValueField="id" SelectedValue='<%# Bind("CuentaID") %>'></asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Monto">
            <ItemTemplate>
                <asp:Label ID="lblMonto" runat="server" Text='<%# Eval("monto") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtEditMonto" runat="server" Text='<%# Bind("monto") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
     <asp:TemplateField HeaderText="Tipo">
    <ItemTemplate>
        <%# Convert.ToBoolean(Eval("tipo")) ? "Haber" : "Debe" %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:RadioButton ID="rbEditIngreso" runat="server" Text="Haber" GroupName="Tipo"
            Checked='<%# Convert.ToBoolean(Eval("tipo")) %>' />
        <asp:RadioButton ID="rbEditEgreso" runat="server" Text="Debe" GroupName="Tipo"
            Checked='<%# !Convert.ToBoolean(Eval("tipo")) %>' />
    </EditItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Acciones">
    <ItemTemplate>
        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" Text="Editar" />
        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" Text="Eliminar" />
    </ItemTemplate>
    <EditItemTemplate>
        <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" Text="Actualizar" />
        <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" Text="Cancelar" />
    </EditItemTemplate>
</asp:TemplateField>    </Columns>
</asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceCuentas" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>"
                SelectCommand="SELECT id, descripcion FROM Cuentas"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>