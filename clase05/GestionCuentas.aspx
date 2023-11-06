<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionCuentas.aspx.cs" Inherits="clase05.GestionCuentas" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Gestión de Cuentas</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
         
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
            margin-bottom: 10px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-container {
    text-align: center;
    margin-top: 20px;
}

.btn-container button {
    display: inline-block;
    margin-right: 10px;
}
        .btn-primary {
            background-color: #007bff;
            color: #fff;
        }

        .btn-danger {
            background-color: #dc3545;
            color: #fff;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #000;
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
    <form id="form1" runat="server">
        <div class="header">
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Menu.aspx" CssClass="link" Text="Menu Principal"></asp:HyperLink>
        </div>
        <div class="input-container">
            <label for="TextBox1">Descripción:</label>
            <asp:TextBox ID="TextBox1" runat="server" placeholder="Ingrese una descripción"></asp:TextBox>
        </div>
        <div class="header">
            <asp:Label ID="Label1" runat="server" CssClass="message" style="margin: 0 auto; margin: 50px;"></asp:Label>
        </div>
        <div class="btn-container">
            <asp:Button ID="Button1" runat="server" Text="Alta" CssClass="btn btn-primary" OnClick="Button1_Click" />
        </div>
        <div class="input-container">
            <label for="ListBox1">Seleccionar Cuenta:</label>
            <asp:DropDownList ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="descripcion" DataValueField="id" CssClass="list-box" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged"></asp:DropDownList>
        </div>
        <div class="input-container">
            <label for="TextBox2">Nueva descripción:</label>
            <asp:TextBox ID="TextBox2" runat="server" placeholder="Nueva descripción"></asp:TextBox>
        </div>
     <div class="btn-container">
    <asp:Button ID="Button3" runat="server" Text="Modificar" CssClass="btn btn-warning" OnClick="Button3_Click" />
</div>
        <div class="message-container">
            <asp:Label ID="MessageLabel" runat="server" CssClass="message"></asp:Label>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>"
            DeleteCommand="DELETE FROM [Cuentas] WHERE [id] = @id" InsertCommand="INSERT INTO [Cuentas] ([descripcion]) VALUES (@descripcion)"
            SelectCommand="SELECT * FROM [Cuentas]" UpdateCommand="UPDATE [Cuentas] SET [descripcion] = @descripcion WHERE [id] = @id">
            <DeleteParameters>
                <asp:ControlParameter ControlID="ListBox1" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox1" Name="descripcion" PropertyName="Text" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="TextBox2" Name="descripcion" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ListBox1" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>"
            SelectCommand="SELECT * FROM [Cuentas] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ListBox1" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
 
    </form>
   
</body>
</html>
