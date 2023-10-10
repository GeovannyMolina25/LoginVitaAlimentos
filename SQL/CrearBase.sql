USE MAster
--GO
--/****** Object:  Database [Prueba]    Script Date: 16/05/2023 8:15:12 ******/
--CREATE DATABASE [Prueba]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'Prueba', FILENAME = N'D:\DATA\Prueba\Prueba.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'Prueba_log', FILENAME = N'D:\DATA\Prueba\Prueba_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 

--GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Prueba].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Prueba] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Prueba] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Prueba] SET ARITHABORT OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Prueba] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Prueba] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Prueba] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Prueba] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Prueba] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Prueba] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Prueba] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Prueba] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Prueba] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Prueba] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Prueba] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Prueba] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Prueba] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Prueba] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Prueba] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Prueba] SET RECOVERY FULL 
GO
ALTER DATABASE [Prueba] SET  MULTI_USER 
GO
ALTER DATABASE [Prueba] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Prueba] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Prueba] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Prueba] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Prueba] SET DELAYED_DURABILITY = DISABLED 
GO
GO
EXEC sys.sp_db_vardecimal_storage_format N'Prueba', N'ON'
GO

GO

USE [Prueba]
GO
/****** Object:  Table [dbo].[AdmEmpresa]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmEmpresa](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codEmpresa] [varchar](16) NOT NULL,
	[nombreEmpresa] [varchar](256) NULL,
 CONSTRAINT [PK_AdmEmpresa_1] PRIMARY KEY CLUSTERED 
(
	[codEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmEstado]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmEstado](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codEstado] [varchar](16) NOT NULL,
	[nombreEstado] [varchar](64) NOT NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_AdmEstado_1] PRIMARY KEY CLUSTERED 
(
	[codEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmFormulario]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmFormulario](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codFormulario] [varchar](16) NOT NULL,
	[nombreFormulario] [varchar](256) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_AdmFormulario_1] PRIMARY KEY CLUSTERED 
(
	[codFormulario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmPermisos]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmPermisos](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codForm] [varchar](192) NOT NULL,
	[carpeta] [varchar](192) NULL,
	[codRol] [varchar](64) NULL,
	[vista] [varchar](192) NULL,
	[etiquetaMenu] [varchar](192) NULL,
	[codEmpresa] [varchar](16) NULL,
	[codEquipo] [varchar](16) NULL,
 CONSTRAINT [PK_AdmPermisos] PRIMARY KEY CLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmProgAccionesFormulario]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmProgAccionesFormulario](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codRegistroFormulario] [int] NULL,
	[Accion] [varchar](50) NULL,
	[creadoPor] [varchar](16) NULL,
	[fechaAccion] [date] NULL,
	[horaActual] [time](3) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_AdmProgAccionesFormulario] PRIMARY KEY CLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmRol]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmRol](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codRol] [varchar](64) NOT NULL,
	[nombreRol] [varchar](150) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_AdmRol] PRIMARY KEY CLUSTERED 
(
	[codRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmSitio]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmSitio](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codSitio] [varchar](16) NOT NULL,
	[nombreSitio] [varchar](128) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_AdmSitio] PRIMARY KEY CLUSTERED 
(
	[codSitio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmUnidadMedida]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmUnidadMedida](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codUnidadMedida] [varchar](16) NOT NULL,
	[nombreUnidadMedida] [varchar](64) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_AdmUnidadMedida] PRIMARY KEY CLUSTERED 
(
	[codUnidadMedida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmUsuario]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmUsuario](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codUsuario] [varchar](16) NOT NULL,
	[contraseña] [varchar](128) NULL,
	[correo] [varchar](256) NULL,
	[resetPass] [varchar](256) NULL,
	[codSitio] [varchar](16) NULL,
	[activo] [int] NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_AdmUsuario] PRIMARY KEY CLUSTERED 
(
	[codUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdmUsuarioRol]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdmUsuarioRol](
	[codUsuarioRol] [int] IDENTITY(1,1) NOT NULL,
	[codUsuario] [varchar](16) NOT NULL,
	[codRol] [varchar](64) NOT NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_Usu_Rol] PRIMARY KEY CLUSTERED 
(
	[codUsuarioRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PQPRODMAQUINA]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PQPRODMAQUINA](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codEquipo] [varchar](32) NOT NULL,
	[nombreEquipo] [varchar](150) NOT NULL,
	[codSitio] [varchar](16) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_Equipo] PRIMARY KEY CLUSTERED 
(
	[codEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProAdmForm]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProAdmForm](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codFormulario] [varchar](16) NULL,
	[codEstado] [varchar](16) NULL,
	[aprobadoPor] [varchar](16) NULL,
	[fechaAprobacion] [date] NULL,
	[horaAprobacion] [time](3) NULL,
	[codEquipo] [varchar](32) NULL,
	[codEmpresa] [varchar](16) NULL,
	[fechaRegistro] [date] NULL,
	[codUsuarioCrea] [varchar](16) NULL,
 CONSTRAINT [PK_ProAdmForm_1] PRIMARY KEY CLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProParametro]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProParametro](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codParametro] [varchar](16) NOT NULL,
	[nombreParametro] [varchar](256) NULL,
	[minimoParametro] [float] NULL,
	[maximoParametro] [float] NULL,
	[codProceso] [varchar](16) NULL,
	[activo] [int] NULL,
	[codUnidadMedida] [varchar](16) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_ProParametro_1] PRIMARY KEY CLUSTERED 
(
	[codParametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProProceso]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProProceso](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[codProceso] [varchar](16) NOT NULL,
	[nombreProceso] [varchar](256) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_ProProceso] PRIMARY KEY CLUSTERED 
(
	[codProceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProRegOprEstREDA1]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProRegOprEstREDA1](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[valorProReg] [float] NULL,
	[fechaTrabajoProReg] [date] NULL,
	[horaTrabajoProReg] [time](3) NULL,
	[fechaCreaProReg] [date] NULL,
	[fechaModProReg] [date] NULL,
	[codUsuarioCrea] [varchar](16) NULL,
	[codUsuarioMod] [varchar](16) NULL,
	[codParametro] [varchar](16) NULL,
	[maximoParametro] [float] NULL,
	[minimoParametro] [float] NULL,
	[nombreUnidadMedida] [varchar](32) NULL,
	[codRegistroFormulario] [int] NULL,
	[codSitio] [varchar](16) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_ProRegOprEstREDA1_1] PRIMARY KEY CLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProRegOprTanASE]    Script Date: 16/05/2023 8:15:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProRegOprTanASE](
	[codRegistro] [int] IDENTITY(1,1) NOT NULL,
	[valorProReg] [float] NULL,
	[fechaTrabajoProReg] [date] NULL,
	[horaTrabajoProReg] [time](3) NULL,
	[fechaCreaProReg] [date] NULL,
	[fechaModProReg] [date] NULL,
	[codUsuarioCrea] [varchar](16) NULL,
	[codUsuarioMod] [varchar](16) NULL,
	[codParametro] [varchar](16) NULL,
	[maximoParametro] [float] NULL,
	[minimoParametro] [float] NULL,
	[nombreUnidadMedida] [varchar](32) NULL,
	[codRegistroFormulario] [int] NULL,
	[codSitio] [varchar](16) NULL,
	[codEmpresa] [varchar](16) NULL,
 CONSTRAINT [PK_ProRegOprTanASE] PRIMARY KEY CLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdmEmpresa] ON 

INSERT [dbo].[AdmEmpresa] ([codRegistro], [codEmpresa], [nombreEmpresa]) VALUES (3, N'VITA', N'VIita Alimentos SA')
SET IDENTITY_INSERT [dbo].[AdmEmpresa] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmEstado] ON 

INSERT [dbo].[AdmEstado] ([codRegistro], [codEstado], [nombreEstado], [codEmpresa]) VALUES (1, N'est1', N'Finalizado', NULL)
INSERT [dbo].[AdmEstado] ([codRegistro], [codEstado], [nombreEstado], [codEmpresa]) VALUES (3, N'est2', N'Aprobado', NULL)
INSERT [dbo].[AdmEstado] ([codRegistro], [codEstado], [nombreEstado], [codEmpresa]) VALUES (4, N'est3', N'Creado', NULL)
INSERT [dbo].[AdmEstado] ([codRegistro], [codEstado], [nombreEstado], [codEmpresa]) VALUES (5, N'est4', N'Rechazado', NULL)
SET IDENTITY_INSERT [dbo].[AdmEstado] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmFormulario] ON 

INSERT [dbo].[AdmFormulario] ([codRegistro], [codFormulario], [nombreFormulario], [codEmpresa]) VALUES (3, N'PRO-RE039', N'Registro Operacional Esterilizador REDA', N'VITA')
INSERT [dbo].[AdmFormulario] ([codRegistro], [codFormulario], [nombreFormulario], [codEmpresa]) VALUES (4, N'PRO-RE040', N'Registro Operacional Tanque Aséptico ', N'VITA')
SET IDENTITY_INSERT [dbo].[AdmFormulario] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmPermisos] ON 

INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (7, N'Permisos', N'AdmPermisos', N'ADMIN', N'Index', N'Permisos', N'VITA', NULL)
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (8, N'Roles', N'AdmRols', N'ADMIN', N'Index', N'Roles', N'VITA', NULL)
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (13, N'Usuarios', N'AdmUsuarios', N'ADMIN', N'Index', N'Usuarios', N'VITA', NULL)
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (24, N'AsignacionRoles', N'AdmUsuarioRols', N'ADMIN', N'Index', N'Rol-Usuario', N'VITA', NULL)
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (29, N'Supervisor', N'ProAdmForms', N'SUPPRODUCCION', N'Index', N'Formularios', N'VITA', NULL)
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (30, N'Aseptico 1', N'ProRegOprTanASEs', N'OPREDA', N'Registros', N'Aséptico 1', N'VITA', N'ASEPTICO1')
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (32, N'Aseptico 2', N'ProRegOprTanASEs', N'OPREDA', N'Registros', N'Aséptico 2', N'VITA', N'ASEPTICO2')
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (35, N'Reda 1', N'proRegOprEstREDA1', N'OPREDA', N'Registros', N'Reda 1', N'VITA', N'REDA1')
INSERT [dbo].[AdmPermisos] ([codRegistro], [codForm], [carpeta], [codRol], [vista], [etiquetaMenu], [codEmpresa], [codEquipo]) VALUES (36, N'Reda 2', N'proRegOprEstREDA1', N'OPREDA', N'Registros', N'Reda 2', N'VITA', N'REDA2')
SET IDENTITY_INSERT [dbo].[AdmPermisos] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmProgAccionesFormulario] ON 

INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (160, 170, N'Creado', N'llara', CAST(N'2023-05-15' AS Date), CAST(N'11:18:24' AS Time), N'VITA')
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (161, 170, N'Creado', N'llara', CAST(N'2023-05-15' AS Date), CAST(N'11:18:52' AS Time), N'VITA')
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (162, 171, N'Creado', N'llara', CAST(N'2023-05-15' AS Date), CAST(N'11:19:15' AS Time), N'VITA')
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (163, 172, N'Creado', N'llara', CAST(N'2023-05-15' AS Date), CAST(N'11:19:38' AS Time), N'VITA')
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (164, 172, N'Creado', N'llara', CAST(N'2023-05-15' AS Date), CAST(N'11:20:01' AS Time), N'VITA')
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (165, 173, N'Creado', N'llara', CAST(N'2023-05-15' AS Date), CAST(N'11:20:37' AS Time), N'VITA')
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (166, 170, N'Creado', N'bvelasco', CAST(N'2023-05-15' AS Date), CAST(N'11:30:53' AS Time), N'VITA')
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (167, 170, N'Finalizado', N'bvelasco', CAST(N'2023-05-15' AS Date), CAST(N'13:14:45' AS Time), NULL)
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (168, 172, N'Finalizado', N'bvelasco', CAST(N'2023-05-15' AS Date), CAST(N'13:14:53' AS Time), NULL)
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (169, 170, N'Rechazado', N'dcajas', CAST(N'2023-05-15' AS Date), CAST(N'13:15:35' AS Time), NULL)
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (170, 172, N'Aprobado', N'dcajas', CAST(N'2023-05-15' AS Date), CAST(N'13:15:38' AS Time), NULL)
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (171, 170, N'Finalizado', N'bvelasco', CAST(N'2023-05-15' AS Date), CAST(N'13:16:24' AS Time), NULL)
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (172, 170, N'Rechazado', N'dcajas', CAST(N'2023-05-15' AS Date), CAST(N'13:29:53' AS Time), NULL)
INSERT [dbo].[AdmProgAccionesFormulario] ([codRegistro], [codRegistroFormulario], [Accion], [creadoPor], [fechaAccion], [horaActual], [codEmpresa]) VALUES (173, 175, N'Creado', N'bvelasco', CAST(N'2023-05-15' AS Date), CAST(N'13:42:34' AS Time), N'VITA')
SET IDENTITY_INSERT [dbo].[AdmProgAccionesFormulario] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmRol] ON 

INSERT [dbo].[AdmRol] ([codRegistro], [codRol], [nombreRol], [codEmpresa]) VALUES (22, N'ADMIN', N'Administrador del sistema', N'VITA')
INSERT [dbo].[AdmRol] ([codRegistro], [codRol], [nombreRol], [codEmpresa]) VALUES (17, N'OPREDA', N'Operador Reda', N'VITA')
INSERT [dbo].[AdmRol] ([codRegistro], [codRol], [nombreRol], [codEmpresa]) VALUES (18, N'SUPPRODUCCION', N'Supervisor de Producción', N'VITA')
SET IDENTITY_INSERT [dbo].[AdmRol] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmSitio] ON 

INSERT [dbo].[AdmSitio] ([codRegistro], [codSitio], [nombreSitio], [codEmpresa]) VALUES (1, N'QUITO', N'Quito', N'VITA')
SET IDENTITY_INSERT [dbo].[AdmSitio] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmUnidadMedida] ON 

INSERT [dbo].[AdmUnidadMedida] ([codRegistro], [codUnidadMedida], [nombreUnidadMedida], [codEmpresa]) VALUES (5, N'%', N'Porcentaje', NULL)
INSERT [dbo].[AdmUnidadMedida] ([codRegistro], [codUnidadMedida], [nombreUnidadMedida], [codEmpresa]) VALUES (3, N'Bar', N'Presión', NULL)
INSERT [dbo].[AdmUnidadMedida] ([codRegistro], [codUnidadMedida], [nombreUnidadMedida], [codEmpresa]) VALUES (4, N'L/h', N'Litros por hora', NULL)
INSERT [dbo].[AdmUnidadMedida] ([codRegistro], [codUnidadMedida], [nombreUnidadMedida], [codEmpresa]) VALUES (2, N'min', N'min', NULL)
INSERT [dbo].[AdmUnidadMedida] ([codRegistro], [codUnidadMedida], [nombreUnidadMedida], [codEmpresa]) VALUES (1, N'ºC', N'Grados Centigrados', NULL)
INSERT [dbo].[AdmUnidadMedida] ([codRegistro], [codUnidadMedida], [nombreUnidadMedida], [codEmpresa]) VALUES (6, N'pH', N'Potencial de Hidrógeno', NULL)
SET IDENTITY_INSERT [dbo].[AdmUnidadMedida] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmUsuario] ON 

INSERT [dbo].[AdmUsuario] ([codRegistro], [codUsuario], [contraseña], [correo], [resetPass], [codSitio], [activo], [codEmpresa]) VALUES (25, N'admin', N'admin2023', N'admin@vita.com.ec', NULL, N'QUITO', 1, N'VITA')
INSERT [dbo].[AdmUsuario] ([codRegistro], [codUsuario], [contraseña], [correo], [resetPass], [codSitio], [activo], [codEmpresa]) VALUES (20, N'bvelasco', N'bvelasco2023', N'bvelasco@vita.com.ec', NULL, N'QUITO', 1, N'VITA')
INSERT [dbo].[AdmUsuario] ([codRegistro], [codUsuario], [contraseña], [correo], [resetPass], [codSitio], [activo], [codEmpresa]) VALUES (24, N'dcajas', N'dcajas2023', N'dcajas@vita.com.ec', NULL, N'QUITO', 1, N'VITA')
INSERT [dbo].[AdmUsuario] ([codRegistro], [codUsuario], [contraseña], [correo], [resetPass], [codSitio], [activo], [codEmpresa]) VALUES (21, N'eproanio', N'eproanio2023', N'eproanio@vita.com.ec', NULL, N'QUITO', 1, N'VITA')
INSERT [dbo].[AdmUsuario] ([codRegistro], [codUsuario], [contraseña], [correo], [resetPass], [codSitio], [activo], [codEmpresa]) VALUES (22, N'llara', N'llara2023', N'llara@vita.com.ec', NULL, N'QUITO', 1, N'VITA')
INSERT [dbo].[AdmUsuario] ([codRegistro], [codUsuario], [contraseña], [correo], [resetPass], [codSitio], [activo], [codEmpresa]) VALUES (23, N'msantos', N'msantos2023', N'msantos@vita.com.ec', NULL, N'QUITO', 1, N'VITA')
SET IDENTITY_INSERT [dbo].[AdmUsuario] OFF
GO
SET IDENTITY_INSERT [dbo].[AdmUsuarioRol] ON 

INSERT [dbo].[AdmUsuarioRol] ([codUsuarioRol], [codUsuario], [codRol], [codEmpresa]) VALUES (49, N'bvelasco', N'OPREDA', N'VITA')
INSERT [dbo].[AdmUsuarioRol] ([codUsuarioRol], [codUsuario], [codRol], [codEmpresa]) VALUES (52, N'eproanio', N'OPREDA', N'VITA')
INSERT [dbo].[AdmUsuarioRol] ([codUsuarioRol], [codUsuario], [codRol], [codEmpresa]) VALUES (53, N'llara', N'OPREDA', N'VITA')
INSERT [dbo].[AdmUsuarioRol] ([codUsuarioRol], [codUsuario], [codRol], [codEmpresa]) VALUES (54, N'msantos', N'OPREDA', N'VITA')
INSERT [dbo].[AdmUsuarioRol] ([codUsuarioRol], [codUsuario], [codRol], [codEmpresa]) VALUES (55, N'dcajas', N'SUPPRODUCCION', N'VITA')
INSERT [dbo].[AdmUsuarioRol] ([codUsuarioRol], [codUsuario], [codRol], [codEmpresa]) VALUES (56, N'admin', N'ADMIN', N'VITA')
SET IDENTITY_INSERT [dbo].[AdmUsuarioRol] OFF
GO
SET IDENTITY_INSERT [dbo].[PQPRODMAQUINA] ON 

INSERT [dbo].[PQPRODMAQUINA] ([codRegistro], [codEquipo], [nombreEquipo], [codSitio], [codEmpresa]) VALUES (5, N'ASEPTICO1', N'ASEPTICO 1', N'Sit1', N'emp1')
INSERT [dbo].[PQPRODMAQUINA] ([codRegistro], [codEquipo], [nombreEquipo], [codSitio], [codEmpresa]) VALUES (7, N'ASEPTICO2', N'ASEPTICO 2', N'Sit1', N'emp1')
INSERT [dbo].[PQPRODMAQUINA] ([codRegistro], [codEquipo], [nombreEquipo], [codSitio], [codEmpresa]) VALUES (1, N'REDA1', N'REDA1', N'Sit1', N'emp1')
INSERT [dbo].[PQPRODMAQUINA] ([codRegistro], [codEquipo], [nombreEquipo], [codSitio], [codEmpresa]) VALUES (2, N'REDA2', N'REDA2', N'Sit1', N'emp1')
SET IDENTITY_INSERT [dbo].[PQPRODMAQUINA] OFF
GO
SET IDENTITY_INSERT [dbo].[ProAdmForm] ON 

INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (170, N'PRO-RE040', N'est4', NULL, CAST(N'2023-05-15' AS Date), CAST(N'13:29:53' AS Time), N'ASEPTICO1', N'VITA', CAST(N'2023-05-15' AS Date), N'llara')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (171, N'PRO-RE040', N'est3', NULL, NULL, NULL, N'ASEPTICO2', N'VITA', CAST(N'2023-05-15' AS Date), N'llara')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (172, N'PRO-RE039', N'est2', N'dcajas', CAST(N'2023-05-15' AS Date), CAST(N'13:15:38' AS Time), N'REDA1', N'VITA', CAST(N'2023-05-15' AS Date), N'llara')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (173, N'PRO-RE039', N'est3', NULL, NULL, NULL, N'REDA2', N'VITA', CAST(N'2023-05-15' AS Date), N'llara')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (175, N'PRO-RE040', N'est3', NULL, NULL, NULL, N'ASEPTICO2', N'VITA', CAST(N'2023-05-14' AS Date), N'bvelasco')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (176, N'PRO-RE039', N'est3', NULL, NULL, NULL, N'REDA2', N'VITA', CAST(N'2023-05-14' AS Date), N'bvelasco')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (177, N'PRO-RE039', N'est3', NULL, NULL, NULL, N'REDA2', N'VITA', CAST(N'2023-05-03' AS Date), N'bvelasco')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (178, N'PRO-RE039', N'est3', NULL, NULL, NULL, N'REDA2', N'VITA', CAST(N'2023-05-01' AS Date), N'bvelasco')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (179, N'PRO-RE039', N'est3', NULL, NULL, NULL, N'REDA2', N'VITA', CAST(N'2023-05-10' AS Date), N'bvelasco')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (180, N'PRO-RE039', N'est3', NULL, NULL, NULL, N'REDA1', N'VITA', CAST(N'2023-05-15' AS Date), N'bvelasco')
INSERT [dbo].[ProAdmForm] ([codRegistro], [codFormulario], [codEstado], [aprobadoPor], [fechaAprobacion], [horaAprobacion], [codEquipo], [codEmpresa], [fechaRegistro], [codUsuarioCrea]) VALUES (181, N'PRO-RE039', N'est3', NULL, NULL, NULL, N'REDA2', N'VITA', CAST(N'2023-05-14' AS Date), N'bvelasco')
SET IDENTITY_INSERT [dbo].[ProAdmForm] OFF
GO
SET IDENTITY_INSERT [dbo].[ProParametro] ON 

INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (1, N'PAROPERREDA01', N'Temperatura precalentamiento', 80, 140, N'PRO001', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (2, N'PAROPERREDA02', N'Tiempo de esterilización del equipo', 30, NULL, N'PRO001', 1, N'min', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (3, N'PAROPERREDA03', N'Temperatura de esterilización del equipo', 140, NULL, N'PRO002', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (4, N'PAROPERREDA04', N'Temperatura de vapor TVT', NULL, 150, N'PRO002', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (5, N'PAROPERREDA05', N'Temperatura salida a Tq Aséptico T2CT', 25, 30, N'PRO002', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (6, N'PAROPERREDA06', N'Temperatura entrada tubo de retención T1T', 135, NULL, N'PRO003', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (7, N'PAROPERREDA07', N'Temperatura salida tubo de retención T1T', 135, NULL, N'PRO003', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (8, N'PAROPERREDA08', N'Presión entrada a homogenizador P3T', 3.5, NULL, N'PRO004', 1, N'Bar', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (9, N'PAROPERREDA09', N'Presión salida de homogenizador P4T', NULL, 9, N'PRO004', 1, N'Bar', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (10, N'PAROPERREDA10', N'Presión de Homogenizador', NULL, 200, N'PRO004', 1, N'Bar', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (11, N'PAROPERREDA11', N'Presión de vapor', NULL, 6, N'PRO004', 1, N'Bar', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (12, N'PAROPERREDA12', N'Presión Tubo de retención', 3, NULL, N'PRO004', 1, N'Bar', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (13, N'PAROPERREDA13', N'Presión Tubo de retención', 12000, 13000, N'PRO005', 1, N'L/h', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (14, N'PAROPERREDA14', N'Concentración de soda', 2, 3, N'PRO006', 1, N'%', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (15, N'PAROPERREDA15', N'Concentración de ácido', 1, 2, N'PRO006', 1, N'%', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (16, N'PAROPERREDA16', N'pH enjuague final', 6.5, 7.4, N'PRO006', 1, N'pH', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (17, N'PAROPERREDA17', N'Flujo de recirculación', 12000, NULL, N'PRO004', 1, N'L/h', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (18, N'PAROPERTASE01', N'Temperatura de esterilización del equipo', 121, NULL, N'PRO007', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (19, N'PAROPERTASE02', N'Tiempo de esterilización del equipo', 30, NULL, N'PRO007', 1, N'min', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (20, N'PAROPERTASE03', N'Temperatura salida REDA a Tq Aséptico T2CT', 25, 30, N'PRO008', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (21, N'PAROPERTASE04', N'Temperatura de producto TT 101', 25, 30, N'PRO008', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (22, N'PAROPERTASE05', N'Barrera de vapor valvula 101 TT 160', 105, 120, N'PRO009', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (23, N'PAROPERTASE06', N'Barrera de vapor TT 140 (V fin Tq)', 105, 120, N'PRO009', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (24, N'PAROPERTASE07', N'Barrera de vapor TT 145 (V fin Tq)', 105, 120, N'PRO009', 1, N'ºC', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (25, N'PAROPERTASE08', N'Presión Tanque', 0.3, NULL, N'PRO010', 1, N'Bar', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (26, N'PAROPERTASE09', N'Presión manómetro PI', 0.3, NULL, N'PRO010', 1, N'Bar', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (27, N'PAROPERTASE10', N'Concentración de soda', 1.8, 2.2, N'PEO011', 1, N'%', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (29, N'PAROPERTASE11', N'Concentración de ácido', 0.8, 1.2, N'PEO011', 1, N'%', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (30, N'PAROPERTASE12', N'pH enjuague final ', 6.5, 7.4, N'PEO011', 1, N'pH', N'emp1')
INSERT [dbo].[ProParametro] ([codRegistro], [codParametro], [nombreParametro], [minimoParametro], [maximoParametro], [codProceso], [activo], [codUnidadMedida], [codEmpresa]) VALUES (31, N'PAROPERTASE13', N'Flujo de recirculación', 14000, NULL, N'PEO011', 1, N'L/h', N'emp1')
SET IDENTITY_INSERT [dbo].[ProParametro] OFF
GO
SET IDENTITY_INSERT [dbo].[ProProceso] ON 

INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (17, N'PEO011', N'CIP', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (1, N'PRO001', N'Esterilización del equipo', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (2, N'PRO002', N'Temperaturas de Operación', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (3, N'PRO003', N'Condiciones Esterilización Producto', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (4, N'PRO004', N'Presiones de Operación', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (5, N'PRO005', N'Flujo de Operación', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (7, N'PRO006', N'CIP', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (8, N'PRO007', N'Temperaturas de Barreras de Vapor', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (9, N'PRO008', N'Temperaturas de Operación', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (14, N'PRO009', N'Temperaturas de Barreras de Vapor', N'emp1')
INSERT [dbo].[ProProceso] ([codRegistro], [codProceso], [nombreProceso], [codEmpresa]) VALUES (15, N'PRO010', N'Presiones de Operación', N'emp1')
SET IDENTITY_INSERT [dbo].[ProProceso] OFF
GO
SET IDENTITY_INSERT [dbo].[ProRegOprEstREDA1] ON 

INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2605, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA01', 140, 80, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2606, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA02', NULL, 30, N'min', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2607, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA03', NULL, 140, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2608, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA04', 150, NULL, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2609, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA05', 30, 25, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2610, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA06', NULL, 135, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2611, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA07', NULL, 135, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2612, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA08', NULL, 3.5, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2613, NULL, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA09', 9, NULL, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2614, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA10', 200, NULL, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2615, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA11', 6, NULL, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2616, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA12', NULL, 3, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2617, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA13', 13000, 12000, N'L/h', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2618, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA14', 3, 2, N'%', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2619, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA15', 2, 1, N'%', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2620, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA16', 7.4000000000000012, 6.5, N'pH', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2621, 4, CAST(N'2023-05-15' AS Date), CAST(N'19:19:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA17', NULL, 12000, N'L/h', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2622, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA01', 140, 80, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2623, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA02', NULL, 30, N'min', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2624, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA03', NULL, 140, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2625, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA04', 150, NULL, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2626, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA05', 30, 25, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2627, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA06', NULL, 135, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2628, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA07', NULL, 135, N'ºC', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2629, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA08', NULL, 3.5, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2630, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA09', 9, NULL, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2631, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA10', 200, NULL, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2632, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA11', 6, NULL, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2633, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA12', NULL, 3, N'Bar', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2634, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA13', 13000, 12000, N'L/h', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2635, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA14', 3, 2, N'%', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2636, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA15', 2, 1, N'%', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2637, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA16', 7.4000000000000012, 6.5, N'pH', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2638, 5, CAST(N'2023-05-15' AS Date), CAST(N'05:05:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA17', NULL, 12000, N'L/h', 172, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2639, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA01', 140, 80, N'ºC', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2640, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA02', NULL, 30, N'min', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2641, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA03', NULL, 140, N'ºC', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2642, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA04', 150, NULL, N'ºC', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2643, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA05', 30, 25, N'ºC', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2644, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA06', NULL, 135, N'ºC', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2645, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA07', NULL, 135, N'ºC', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2646, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA08', NULL, 3.5, N'Bar', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2647, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA09', 9, NULL, N'Bar', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2648, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA10', 200, NULL, N'Bar', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2649, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA11', 6, NULL, N'Bar', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2650, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA12', NULL, 3, N'Bar', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2651, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA13', 13000, 12000, N'L/h', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2652, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA14', 3, 2, N'%', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2653, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA15', 2, 1, N'%', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2654, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA16', 7.4000000000000012, 6.5, N'pH', 173, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprEstREDA1] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (2655, 9, CAST(N'2023-05-15' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERREDA17', NULL, 12000, N'L/h', 173, N'QUITO', N'VITA')
SET IDENTITY_INSERT [dbo].[ProRegOprEstREDA1] OFF
GO
SET IDENTITY_INSERT [dbo].[ProRegOprTanASE] ON 

INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (283, 10, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE01', NULL, 121, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (284, 10, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE02', NULL, 30, N'min', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (285, 10, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE03', 30, 25, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (286, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE04', 30, 25, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (287, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE05', 120, 105, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (288, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE06', 120, 105, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (289, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE07', 120, 105, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (290, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE08', NULL, 0.29999999999999993, N'Bar', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (291, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE09', NULL, 0.29999999999999993, N'Bar', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (292, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE10', 2.1999999999999957, 1.8000000000000043, N'%', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (293, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE11', 1.1999999999999957, 0.79999999999999993, N'%', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (294, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE12', 7.4000000000000012, 6.5, N'pH', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (295, 1, CAST(N'2023-05-15' AS Date), CAST(N'11:00:00' AS Time), CAST(N'2023-05-15' AS Date), CAST(N'2023-05-15' AS Date), N'llara', N'bvelasco', N'PAROPERTASE13', NULL, 14000, N'L/h', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (296, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE01', NULL, 121, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (297, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE02', NULL, 30, N'min', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (298, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE03', 30, 25, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (299, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE04', 30, 25, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (300, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE05', 120, 105, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (301, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE06', 120, 105, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (302, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE07', 120, 105, N'ºC', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (303, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE08', NULL, 0.29999999999999993, N'Bar', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (304, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE09', NULL, 0.29999999999999993, N'Bar', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (305, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE10', 2.1999999999999957, 1.8000000000000043, N'%', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (306, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE11', 1.1999999999999957, 0.79999999999999993, N'%', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (307, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE12', 7.4000000000000012, 6.5, N'pH', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (308, 2, CAST(N'2023-05-15' AS Date), CAST(N'15:15:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE13', NULL, 14000, N'L/h', 170, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (309, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE01', NULL, 121, N'ºC', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (310, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE02', NULL, 30, N'min', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (311, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE03', 30, 25, N'ºC', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (312, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE04', 30, 25, N'ºC', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (313, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE05', 120, 105, N'ºC', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (314, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE06', 120, 105, N'ºC', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (315, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE07', 120, 105, N'ºC', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (316, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE08', NULL, 0.29999999999999993, N'Bar', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (317, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE09', NULL, 0.29999999999999993, N'Bar', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (318, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE10', 2.1999999999999957, 1.8000000000000043, N'%', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (319, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE11', 1.1999999999999957, 0.79999999999999993, N'%', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (320, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE12', 7.4000000000000012, 6.5, N'pH', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (321, 3, CAST(N'2023-05-15' AS Date), CAST(N'06:06:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'llara', NULL, N'PAROPERTASE13', NULL, 14000, N'L/h', 171, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (335, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE01', NULL, 121, N'ºC', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (336, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE02', NULL, 30, N'min', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (337, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE03', 30, 25, N'ºC', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (338, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE04', 30, 25, N'ºC', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (339, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE05', 120, 105, N'ºC', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (340, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE06', 120, 105, N'ºC', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (341, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE07', 120, 105, N'ºC', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (342, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE08', NULL, 0.29999999999999993, N'Bar', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (343, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE09', NULL, 0.29999999999999993, N'Bar', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (344, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE10', 2.1999999999999957, 1.8000000000000043, N'%', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (345, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE11', 1.1999999999999957, 0.79999999999999993, N'%', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (346, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE12', 7.4000000000000012, 6.5, N'pH', 175, N'QUITO', N'VITA')
INSERT [dbo].[ProRegOprTanASE] ([codRegistro], [valorProReg], [fechaTrabajoProReg], [horaTrabajoProReg], [fechaCreaProReg], [fechaModProReg], [codUsuarioCrea], [codUsuarioMod], [codParametro], [maximoParametro], [minimoParametro], [nombreUnidadMedida], [codRegistroFormulario], [codSitio], [codEmpresa]) VALUES (347, NULL, CAST(N'2023-05-14' AS Date), CAST(N'10:10:00' AS Time), CAST(N'2023-05-15' AS Date), NULL, N'bvelasco', NULL, N'PAROPERTASE13', NULL, 14000, N'L/h', 175, N'QUITO', N'VITA')
SET IDENTITY_INSERT [dbo].[ProRegOprTanASE] OFF
GO
/****** Object:  Index [codRegistroEmpresa]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmEmpresa] ADD  CONSTRAINT [codRegistroEmpresa] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroEstado]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmEstado] ADD  CONSTRAINT [codRegistroEstado] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nombreEstado]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmEstado] ADD  CONSTRAINT [nombreEstado] UNIQUE NONCLUSTERED 
(
	[nombreEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroFormulario]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmFormulario] ADD  CONSTRAINT [codRegistroFormulario] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nombreFormulario]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmFormulario] ADD  CONSTRAINT [nombreFormulario] UNIQUE NONCLUSTERED 
(
	[nombreFormulario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [codForm]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmPermisos] ADD  CONSTRAINT [codForm] UNIQUE NONCLUSTERED 
(
	[codForm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroRol]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmRol] ADD  CONSTRAINT [codRegistroRol] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nombreRol]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmRol] ADD  CONSTRAINT [nombreRol] UNIQUE NONCLUSTERED 
(
	[nombreRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroSitio]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmSitio] ADD  CONSTRAINT [codRegistroSitio] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroUnidadMedida]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmUnidadMedida] ADD  CONSTRAINT [codRegistroUnidadMedida] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nombreUnidadMedida]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmUnidadMedida] ADD  CONSTRAINT [nombreUnidadMedida] UNIQUE NONCLUSTERED 
(
	[nombreUnidadMedida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroUsuario]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[AdmUsuario] ADD  CONSTRAINT [codRegistroUsuario] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroParametro]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[ProParametro] ADD  CONSTRAINT [codRegistroParametro] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
/****** Object:  Index [codRegistroProceso]    Script Date: 16/05/2023 8:15:13 ******/
ALTER TABLE [dbo].[ProProceso] ADD  CONSTRAINT [codRegistroProceso] UNIQUE NONCLUSTERED 
(
	[codRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON  ) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdmPermisos]  WITH CHECK ADD  CONSTRAINT [FK_AdmPermisos_AdmRol] FOREIGN KEY([codRol])
REFERENCES [dbo].[AdmRol] ([codRol])
ON UPDATE CASCADE
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[AdmPermisos] CHECK CONSTRAINT [FK_AdmPermisos_AdmRol]
GO
ALTER TABLE [dbo].[AdmProgAccionesFormulario]  WITH CHECK ADD  CONSTRAINT [FK_AdmProgAccionesFormulario_ProAdmForm] FOREIGN KEY([codRegistroFormulario])
REFERENCES [dbo].[ProAdmForm] ([codRegistro])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdmProgAccionesFormulario] CHECK CONSTRAINT [FK_AdmProgAccionesFormulario_ProAdmForm]
GO
ALTER TABLE [dbo].[AdmSitio]  WITH CHECK ADD  CONSTRAINT [FK_AdmSitio_AdmEmpresa1] FOREIGN KEY([codEmpresa])
REFERENCES [dbo].[AdmEmpresa] ([codEmpresa])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[AdmSitio] CHECK CONSTRAINT [FK_AdmSitio_AdmEmpresa1]
GO
ALTER TABLE [dbo].[AdmUsuario]  WITH CHECK ADD  CONSTRAINT [FK_AdmUsuario_AdmSitio] FOREIGN KEY([codSitio])
REFERENCES [dbo].[AdmSitio] ([codSitio])
ON UPDATE CASCADE
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[AdmUsuario] CHECK CONSTRAINT [FK_AdmUsuario_AdmSitio]
GO
ALTER TABLE [dbo].[AdmUsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_AdmUsuarioRol_AdmRol] FOREIGN KEY([codRol])
REFERENCES [dbo].[AdmRol] ([codRol])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdmUsuarioRol] CHECK CONSTRAINT [FK_AdmUsuarioRol_AdmRol]
GO
ALTER TABLE [dbo].[AdmUsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_AdmUsuarioRol_AdmUsuario] FOREIGN KEY([codUsuario])
REFERENCES [dbo].[AdmUsuario] ([codUsuario])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AdmUsuarioRol] CHECK CONSTRAINT [FK_AdmUsuarioRol_AdmUsuario]
GO
ALTER TABLE [dbo].[ProAdmForm]  WITH CHECK ADD  CONSTRAINT [FK_ProAdmForm_AdmEstado] FOREIGN KEY([codEstado])
REFERENCES [dbo].[AdmEstado] ([codEstado])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProAdmForm] CHECK CONSTRAINT [FK_ProAdmForm_AdmEstado]
GO
ALTER TABLE [dbo].[ProAdmForm]  WITH CHECK ADD  CONSTRAINT [FK_ProAdmForm_AdmFormulario] FOREIGN KEY([codFormulario])
REFERENCES [dbo].[AdmFormulario] ([codFormulario])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProAdmForm] CHECK CONSTRAINT [FK_ProAdmForm_AdmFormulario]
GO
ALTER TABLE [dbo].[ProAdmForm]  WITH CHECK ADD  CONSTRAINT [FK_ProAdmForm_Equipo] FOREIGN KEY([codEquipo])
REFERENCES [dbo].[PQPRODMAQUINA] ([codEquipo])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProAdmForm] CHECK CONSTRAINT [FK_ProAdmForm_Equipo]
GO
ALTER TABLE [dbo].[ProParametro]  WITH CHECK ADD  CONSTRAINT [FK_ProParametro_AdmUnidadMedida] FOREIGN KEY([codUnidadMedida])
REFERENCES [dbo].[AdmUnidadMedida] ([codUnidadMedida])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProParametro] CHECK CONSTRAINT [FK_ProParametro_AdmUnidadMedida]
GO
ALTER TABLE [dbo].[ProParametro]  WITH CHECK ADD  CONSTRAINT [FK_ProParametro_ProProceso] FOREIGN KEY([codProceso])
REFERENCES [dbo].[ProProceso] ([codProceso])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProParametro] CHECK CONSTRAINT [FK_ProParametro_ProProceso]
GO
ALTER TABLE [dbo].[ProRegOprEstREDA1]  WITH CHECK ADD  CONSTRAINT [FK_ProRegOprEstREDA1_AdmUsuario] FOREIGN KEY([codUsuarioCrea])
REFERENCES [dbo].[AdmUsuario] ([codUsuario])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProRegOprEstREDA1] CHECK CONSTRAINT [FK_ProRegOprEstREDA1_AdmUsuario]
GO
ALTER TABLE [dbo].[ProRegOprEstREDA1]  WITH CHECK ADD  CONSTRAINT [FK_ProRegOprEstREDA1_ProAdmForm] FOREIGN KEY([codRegistroFormulario])
REFERENCES [dbo].[ProAdmForm] ([codRegistro])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProRegOprEstREDA1] CHECK CONSTRAINT [FK_ProRegOprEstREDA1_ProAdmForm]
GO
ALTER TABLE [dbo].[ProRegOprEstREDA1]  WITH CHECK ADD  CONSTRAINT [FK_ProRegOprEstREDA1_ProParametro] FOREIGN KEY([codParametro])
REFERENCES [dbo].[ProParametro] ([codParametro])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProRegOprEstREDA1] CHECK CONSTRAINT [FK_ProRegOprEstREDA1_ProParametro]
GO
ALTER TABLE [dbo].[ProRegOprTanASE]  WITH CHECK ADD  CONSTRAINT [FK_ProRegOprTanASE_AdmUsuario] FOREIGN KEY([codUsuarioCrea])
REFERENCES [dbo].[AdmUsuario] ([codUsuario])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProRegOprTanASE] CHECK CONSTRAINT [FK_ProRegOprTanASE_AdmUsuario]
GO
ALTER TABLE [dbo].[ProRegOprTanASE]  WITH CHECK ADD  CONSTRAINT [FK_ProRegOprTanASE_ProAdmForm] FOREIGN KEY([codRegistroFormulario])
REFERENCES [dbo].[ProAdmForm] ([codRegistro])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProRegOprTanASE] CHECK CONSTRAINT [FK_ProRegOprTanASE_ProAdmForm]
GO
ALTER TABLE [dbo].[ProRegOprTanASE]  WITH CHECK ADD  CONSTRAINT [FK_ProRegOprTanASE_ProParametro1] FOREIGN KEY([codParametro])
REFERENCES [dbo].[ProParametro] ([codParametro])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProRegOprTanASE] CHECK CONSTRAINT [FK_ProRegOprTanASE_ProParametro1]
GO
USE [master]
GO
ALTER DATABASE [Prueba] SET  READ_WRITE 
GO
