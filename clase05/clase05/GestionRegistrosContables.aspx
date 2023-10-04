<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionRegistrosContables.aspx.cs" Inherits="clase05.GestionRegistrosContables" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Registros Contables</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 24px;
            color: #333;
            text-align: center;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="button"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
            font-size: 16px;
        }

        input[type="button"] {
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }

        input[type="button"]:hover {
            background-color: #0056b3;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
        }

        .list-box {
            height: 150px;
            overflow-y: auto;
        }

        .table-container {
            width: 100%;
            overflow-x: auto;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container">
            <h1>Gestión de Registros Contables</h1>
                        <asp:Table ID="Table1" runat="server" Width="100%">
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Menu.aspx">Menú</asp:HyperLink>

            <label for="TextBox1">Monto:</label>
            <asp:TextBox ID="TextBox1" placeholder="Monto" runat="server"></asp:TextBox>

            <asp:DropDownList ID="DropDownList1" runat="server" Height="18px" Width="150px" DataSourceID="SqlDataSource1" DataTextField="descripcion" DataValueField="id">
            </asp:DropDownList>

            <label for="TextBox2">Debe (true) / Haber (false):</label>
            <asp:TextBox ID="TextBox2" placeholder="Debe=true/Haber=false" runat="server"></asp:TextBox>

            <div class="action-buttons">
                <asp:Button ID="Button1" runat="server" Text="Agregar" OnClick="Button1_Click" />
                <asp:Button ID="Button2" runat="server" Text="Modificar" OnClick="Button2_Click" />
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </div>

            <div class="list-box">
                <asp:DropDownList ID="DropDownList2" runat="server" Height="16px" Width="160px" DataSourceID="SqlDataSource2" DataTextField="monto" DataValueField="id" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:Button ID="Button3" runat="server" Text="Borrar" OnClick="Button3_Click" />
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cuenta</th>
                            <th>Monto</th>
                            <th>Tipo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Los registros de la tabla se generarán dinámicamente en el código C# -->
                    </tbody>
                </table>
            </div>
        </div>
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