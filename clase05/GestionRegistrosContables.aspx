<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionRegistrosContables.aspx.cs" Inherits="clase05.GestionRegistrosContables" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestion Registros Contables</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            max-width: 600px;
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
    <form id="form1" runat="server">
        <div class="header">
            Gestion Registros Contables
        </div>
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Menu.aspx" CssClass="link">Menu</asp:HyperLink>
        <div class="input-container">
            <label for="TextBox1">Monto</label>
            <asp:TextBox ID="TextBox1" placeholder="Monto" runat="server"></asp:TextBox>
        </div>
        <div class="input-container">
            <label for="DropDownList1">Cuenta</label>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="list-box" DataSourceID="SqlDataSource1" DataTextField="descripcion" DataValueField="id"></asp:DropDownList>
        </div>
        <div class="input-container">
            <label for="TextBox2">Debe (true) / Haber (false)</label>
            <asp:TextBox ID="TextBox2" placeholder="Debe=true/haber=false" runat="server"></asp:TextBox>
        </div>
        <div class="btn-container">
            <asp:Button ID="Button1" runat="server" Text="Agregar" OnClick="Button1_Click" CssClass="btn btn-primary" />
            <asp:Button ID="Button2" runat="server" Text="Modificar" OnClick="Button2_Click" CssClass="btn btn-warning" />
        </div>
        <asp:Label ID="Label1" runat="server" CssClass="label"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="list-box" DataSourceID="SqlDataSource2" DataTextField="monto" DataValueField="id" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
        </asp:DropDownList>
        <div class="btn-container">
            <asp:Button ID="Button3" runat="server" Text="Borrar" OnClick="Button3_Click" CssClass="btn btn-danger" />
        </div>
        <br />
        <br />
        <asp:Table ID="Table1" runat="server" Width="100%">
        </asp:Table>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [Cuentas]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" DeleteCommand="DELETE FROM [RegistrosContables] WHERE [id] = @id" InsertCommand="INSERT INTO [RegistrosContables] ([idCuenta], [monto], [tipo]) VALUES (@idCuenta, @monto, @tipo)" SelectCommand="SELECT * FROM [RegistrosContables]" UpdateCommand="UPDATE [RegistrosContables] SET [idCuenta] = @idCuenta, [monto] = @monto, [tipo] = @tipo WHERE [id] = @id">
            <DeleteParameters>
                <asp:ControlParameter ControlID="DropDownList2" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="idCuenta" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" Name="monto" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox2" Name="tipo" PropertyName="Text" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="idCuenta" PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" Name="monto" PropertyName="Text" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox2" Name="tipo" PropertyName="Text" Type="Boolean" />
                <asp:ControlParameter ControlID="DropDownList2" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT RegistrosContables.id, RegistrosContables.idCuenta, RegistrosContables.monto, RegistrosContables.tipo, Cuentas.descripcion FROM RegistrosContables INNER JOIN Cuentas ON RegistrosContables.idCuenta = Cuentas.id"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:cadena %>" SelectCommand="SELECT * FROM [RegistrosContables] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList2" Name="id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>