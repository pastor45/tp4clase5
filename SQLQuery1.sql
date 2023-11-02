CREATE TABLE Cuentas (
    id INT PRIMARY KEY IDENTITY(1, 1),
    descripcion VARCHAR(50)
);

CREATE TABLE RegistrosContables (
    id INT PRIMARY KEY IDENTITY(1, 1),
    idCuenta INT FOREIGN KEY REFERENCES Cuentas(id),
    monto INT,
    tipo BIT
);

