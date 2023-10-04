<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="clase05.Menu" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Menú</title>
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

        .menu-container {
            text-align: center;
            background-color: #007bff;
            color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            margin: 0 auto;
        }

        .menu-title {
            font-size: 28px;
            margin-bottom: 20px;
        }

        .menu-link {
            display: block;
            margin: 10px auto;
            padding: 15px 30px;
            text-decoration: none;
            color: #fff;
            background-color: #0056b3;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s ease;
            max-width: 100%;
            width: 100%;
            box-sizing: border-box;
        }

        .menu-link:hover {
            background-color: #004080;
        }
    </style>
</head>
<body>
    <div class="menu-container">
        <h1 class="menu-title">Menú Principal</h1>
        <form id="form1" runat="server">
            <div>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/GestionCuentas.aspx" CssClass="menu-link">Gestión de Cuentas</asp:HyperLink>
            </div>
            <div>
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/GestionRegistrosContables.aspx" CssClass="menu-link">Gestión de Registros Contables</asp:HyperLink>
            </div>
        </form>
    </div>
</body>
</html>
