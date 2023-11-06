<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionRegistrosContables.aspx.cs" Inherits="clase05.GestionRegistrosContables" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Gestión de Registros Contables</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 0;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    form {
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
    }

    .header {
        text-align: center;
        font-size: 24px;
        margin-bottom: 20px;
    }

    .link {
        font-size: 18px;
        text-decoration: none;
        color: #007bff;
    }

    .link:hover {
        text-decoration: underline;
    }

    .input-container {
        margin-bottom: 20px;
    }

    .input-container label {
        font-size: 16px;
        margin-bottom: 5px;
    }

    .input-container input[type="text"],
    .input-container select {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        outline: none;
    }

    .btn-container {
        text-align: center;
        margin-top: 20px;
                margin-bottom: 20px;

    }

    .btn {
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 10px;
    }

    .btn-primary {
        background-color: #007bff;
        color: #fff;
        font-family: 'Arial', sans-serif;
    }
    .btn-danger {
        background-color: #dc3545;
        color: #fff;
        font-family: 'Arial', sans-serif;
    }

    .btn-warning {
        background-color: #ffc107;
        color: #000;
        font-family: 'Arial', sans-serif;
    }

    .label {
        font-size: 16px;
        margin-top: 10px;
        text-align: center;
    }

    .list-box {
        width: 100%;
    }

    .message {
        font-weight: bold;
        color: #007bff;
        text-align: center;
        font-size: 12px;
    }
</style>
</head>
<body>
    <form id="form2" runat="server">
        <div class="header">
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Menu.aspx" CssClass="link" Text="Volver al Menú Principal"></asp:HyperLink>
        </div>
        <div class="input-container">
            <label for="DropDownList1">Seleccionar Cuenta:</label>
<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataTextField="descripcion" DataValueField="id" CssClass="list-box" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
        </div>
        <div class="input-container">
            <label for="TextBoxMonto">Monto:</label>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="Ingrese el monto" type="number" step="1"></asp:TextBox>
        </div>
        <div class="input-container">
            <label for="RadioButtonListTipo">Tipo:</label>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Text="Debe" Value="0" />
                <asp:ListItem Text="Haber" Value="1" />
            </asp:RadioButtonList>
        </div>
        <div class="header">
            <asp:Label ID="Label1" runat="server" CssClass="message"></asp:Label>
        </div>
        <div class="btn-container">
            <asp:Button ID="Button1" runat="server" Text="Crear" CssClass="btn btn-primary" OnClick="ButtonCrear_Click" />
        </div>
        <div class="message-container">
            <asp:Label ID="Label2" runat="server" CssClass="message"></asp:Label>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>"
            SelectCommand="SELECT id, descripcion FROM Cuentas" />
                    <div class="table-container">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" DataKeyNames="RegistroID">
    <Columns>
        <asp:BoundField DataField="RegistroID" HeaderText="ID Registro" />
        <asp:BoundField DataField="CuentaID" HeaderText="ID Cuenta" />
        <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
        <asp:BoundField DataField="monto" HeaderText="Monto" DataFormatString="{0:C}" />
        <asp:TemplateField HeaderText="Tipo">
            <ItemTemplate>
                <%# Eval("tipo") == "1" ? "Haber" : "Debe" %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:ButtonField ButtonType="Button" Text="Eliminar" CommandName="EliminarRegistro"     ControlStyle-CssClass="btn-danger"/>
    </Columns>
</asp:GridView>
</div>
    </form>
    
</body>
</html>