using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls.WebParts;
using Antlr.Runtime;
using Crud2.Models;

namespace Crud2.Controllers
{
    public class ProRegOprTanASEsController : Controller
    {
        private readonly SistemaEntities db = new SistemaEntities();
        private void CargarDatosUsuario()
        {
            var user = (AdmUsuario)Session["User"];
            ViewBag.codUsuario = user.codUsuario;
            var empresa = (from d in db.AdmEmpresa
                           where d.codEmpresa == user.codEmpresa
                           select d.nombreEmpresa).FirstOrDefault();
            ViewBag.Empresa = empresa;
            var oRoles = (from d in db.AdmUsuarioRol
                          where d.codUsuario == user.codUsuario
                          select d.codRol).ToList();
            ViewBag.codRol = oRoles;
            var permisos = db.AdmPermisos.Where(p => oRoles.Contains(p.codRol)).ToList(); // Obtener todos los registros que corresponden a los roles del usuario
            ViewBag.Permisos = permisos; // Pasar la lista de permisos a la 

        }


        public ActionResult Registros(string codEquipo, DateTime? fecha)
        {
            CargarDatosUsuario();
            var proAdmForm = db.ProAdmForm.Include(p => p.AdmEstado).Include(p => p.AdmFormulario).Include(p => p.PQPRODMAQUINA);
         /*RCAJAS
          * var data = proAdmForm
               .Where(p => p.codEquipo == codEquipo)
               .ToList();
         */
            DateTime fechaSeleccionada = fecha ?? (DateTime?)Session["fechaSeleccionada"] ?? DateTime.Now;

            // Almacenar la fecha seleccionada en la ViewBag para que se pueda usar en la vista
            ViewBag.FechaSeleccionada = fechaSeleccionada;

            // Filtrar los registros por la fecha seleccionada y la etiquetaMenu
            var data1 = proAdmForm
               // .Where(d => d.fechaRegistro.HasValue && DbFunctions.TruncateTime(d.fechaRegistro.Value) == fechaSeleccionada.Date)
                .Where(d => d.codEquipo == codEquipo)
                .OrderByDescending(p => p.fechaRegistro).Take(15)
                .ToList();
            ViewBag.codEquipo = codEquipo;
            // Almacenar la fecha seleccionada en la sesión
            Session["fechaSeleccionada"] = fechaSeleccionada;

            return View(data1);
        }


        public ActionResult CreateRegistros(DateTime? fecha, string codEquipo, string btnActualizar)
        {
            if (ModelState.IsValid)
            {
                var user = (AdmUsuario)Session["User"];
                CargarDatosUsuario();
                if (btnActualizar != null)
                {
                    var proAdmForm = db.ProAdmForm.Include(p => p.AdmEstado).Include(p => p.AdmFormulario).Include(p => p.PQPRODMAQUINA);
                    var data = proAdmForm
                       .Where(p => p.codEquipo == codEquipo);
                    CargarDatosUsuario();
                    DateTime fechaSeleccionada = fecha ?? (DateTime?)Session["fechaSeleccionada"] ?? DateTime.Now;

                    // Almacenar la fecha seleccionada en la ViewBag para que se pueda usar en la vista
                    ViewBag.FechaSeleccionada = fechaSeleccionada;

                    // Filtrar los registros por la fecha seleccionada y la etiquetaMenu
                    var data1 = proAdmForm
                        .Where(d => d.fechaRegistro.HasValue && DbFunctions.TruncateTime(d.fechaRegistro.Value) == fechaSeleccionada.Date)
                        .Where(d => d.codEquipo == codEquipo)
                        .ToList();
                    ViewBag.codEquipo = codEquipo;
                    // Almacenar la fecha seleccionada en la sesión
                    Session["fechaSeleccionada"] = fechaSeleccionada;

                    return RedirectToAction("Registros", new { codEquipo = codEquipo, fecha = fecha });
                }
                else
                {
                    // Acción para el botón "Crear"
                    // Realiza las operaciones necesarias para crear un nuevo registro
                    var proAdmForm = new ProAdmForm
                    {
                        codFormulario = "PRO-RE040",
                        codEstado = "est3",
                        fechaRegistro = fecha,
                        codEquipo = codEquipo,
                        codEmpresa = user.codEmpresa,
                        codUsuarioCrea = user.codUsuario
                    };
                    ViewBag.codEquipo = codEquipo;
                    db.ProAdmForm.Add(proAdmForm);
                    db.SaveChanges();
                    return RedirectToAction("Registros", new { codEquipo = codEquipo, fecha = fecha });
                }
            }
            ViewBag.codEquipo = codEquipo;
            return RedirectToAction("Registros", new { codEquipo = codEquipo, fecha = fecha });
        }


        // GET: ProRegOprTanASEs

        public ActionResult Index(TimeSpan? hour, string codEstado, string codEquipo, DateTime? fecha, int codRegistro)
        {
            if (hour == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            ViewBag.codRegistro = codRegistro;
            ViewBag.codEstado = codEstado;
            ViewBag.codEquipo = codEquipo;
            ViewBag.hora = hour;
            ViewBag.fecha = fecha;
            CargarDatosUsuario();

            var proRegOprTanASE = db.ProRegOprTanASE
                .Include(p => p.AdmUsuario)
                .Include(p => p.ProAdmForm)
                .Include(p => p.ProParametro)
                .Include(p => p.ProAdmForm.AdmEstado)
                .Where(p => p.horaTrabajoProReg == hour)
                .Where(p => p.codRegistroFormulario == codRegistro);

            return View(proRegOprTanASE.ToList());
        }

        public ActionResult ListaForms(DateTime? fecha, string codEquipo, int codRegistro, string estado)
        {
            CargarDatosUsuario();
            ViewBag.fecha = fecha;
            var proRegOprTanASE = db.ProRegOprTanASE
                .Include(p => p.AdmUsuario)
                .Include(p => p.ProAdmForm)
                .Include(p => p.ProParametro)
                .Include(p => p.ProAdmForm.AdmEstado)
                .Include(p => p.ProAdmForm)
                .Where(p => p.ProAdmForm.codEquipo == codEquipo)
                .Where(p => p.fechaTrabajoProReg == fecha)
                .Where(p => p.codRegistroFormulario == codRegistro)
                .OrderByDescending(p => p.horaTrabajoProReg)
                .ToList();
            ViewBag.codEquipo = codEquipo;
            ViewBag.codRegistro = codRegistro;
            ViewBag.estado = estado;
            return View(proRegOprTanASE);
        }



        ////////////////////////////////////////////////////////////////CREAR/////////////////////////////////////////////////

        // GET: ProRegOprTanASEs/Create
        public ActionResult Create(string codEquipo, int codRegistro, DateTime? fecha, string codEstado)
        {
            CargarDatosUsuario();
            ViewBag.fecha = fecha;
            ViewBag.estado = codEstado;
            ViewBag.codEquipo = codEquipo;
            ViewBag.codRegistro = codRegistro;
            ViewBag.codUsuarioCrea = new SelectList(db.AdmUsuario, "codUsuario", "contraseña");
            ViewBag.codRegistroFormulario = new SelectList(db.ProAdmForm, "codRegistro", "codFormulario");
            ViewBag.codParametro = new SelectList(db.ProParametro, "codParametro", "nombreParametro");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(DateTime fecha, string codEquipo, TimeSpan hora, int codRegistro, string estado, string PAROPERTASE01 = null, string PAROPERTASE02 = null, string PAROPERTASE03 = null, string PAROPERTASE04 = null, string PAROPERTASE05 = null,
            string PAROPERTASE06 = null, string PAROPERTASE07 = null, string PAROPERTASE08 = null, string PAROPERTASE09 = null, string PAROPERTASE10 = null, string PAROPERTASE11 = null, string PAROPERTASE12 = null, string PAROPERTASE13 = null)
        {
            var user = (AdmUsuario)Session["User"];

            CargarDatosUsuario();
            try
            {

                var codRegistroFormulario = codRegistro;
                TimeSpan horaAccion;
                DateTime now = DateTime.Now;
                horaAccion = new TimeSpan(now.Hour, now.Minute, now.Second);
                var proAcciones = new AdmProgAccionesFormulario();
                proAcciones = new AdmProgAccionesFormulario
                {
                    codRegistroFormulario = codRegistroFormulario,
                    creadoPor = user.codUsuario,
                    Accion = "Creado",
                    fechaAccion = DateTime.Now,
                    horaActual = horaAccion,
                    codEmpresa = user.codEmpresa
                };
                db.AdmProgAccionesFormulario.Add(proAcciones);
                db.SaveChanges();


                var Ase = new ProRegOprTanASE();
                if (PAROPERTASE01 != "")
                {
                    var valor = PAROPERTASE01.Replace(".", ",");


                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE01",
                        valorProReg = Double.Parse(valor),
                        minimoParametro = buscarMin("PAROPERTASE01"),
                        maximoParametro = buscarMax("PAROPERTASE01"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE01"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);

                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE01",
                        valorProReg = null, 
                        minimoParametro = buscarMin("PAROPERTASE01"),
                        maximoParametro = buscarMax("PAROPERTASE01"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE01"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                if (PAROPERTASE02 != "")
                {
                    var valor2 = PAROPERTASE02.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE02",
                        valorProReg = Double.Parse(valor2),
                        minimoParametro = buscarMin("PAROPERTASE02"),
                        maximoParametro = buscarMax("PAROPERTASE02"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE02"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE02",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE02"),
                        maximoParametro = buscarMax("PAROPERTASE02"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE02"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                if (PAROPERTASE03 != "")
                {
                    var valor3 = PAROPERTASE03.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE03",
                        valorProReg = Double.Parse(valor3),
                        minimoParametro = buscarMin("PAROPERTASE03"),
                        maximoParametro = buscarMax("PAROPERTASE03"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE03"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE03",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE03"),
                        maximoParametro = buscarMax("PAROPERTASE03"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE03"), 
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }

                if (PAROPERTASE04 != "")
                {
                    var valor4 = PAROPERTASE04.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE04",
                        valorProReg = Double.Parse(valor4),
                        minimoParametro = buscarMin("PAROPERTASE04"),
                        maximoParametro = buscarMax("PAROPERTASE04"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE04"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE04",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE04"),
                        maximoParametro = buscarMax("PAROPERTASE04"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE04"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }


                if (PAROPERTASE05 != "")
                {
                    var valor5 = PAROPERTASE05.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE05",
                        valorProReg = Double.Parse(valor5),
                        minimoParametro = buscarMin("PAROPERTASE05"),
                        maximoParametro = buscarMax("PAROPERTASE05"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE05"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE05",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE05"),
                        maximoParametro = buscarMax("PAROPERTASE05"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE05"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }


                if (PAROPERTASE06 != "")
                {
                    var valor6 = PAROPERTASE06.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE06",
                        valorProReg = Double.Parse(valor6),
                        minimoParametro = buscarMin("PAROPERTASE06"),
                        maximoParametro = buscarMax("PAROPERTASE06"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE06"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE06",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE06"),
                        maximoParametro = buscarMax("PAROPERTASE06"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE06"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }


                if (PAROPERTASE07 != "")
                {
                    var valor7 = PAROPERTASE07.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE07",
                        valorProReg = Double.Parse(valor7),
                        minimoParametro = buscarMin("PAROPERTASE07"),
                        maximoParametro = buscarMax("PAROPERTASE07"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE07"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE07",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE07"),
                        maximoParametro = buscarMax("PAROPERTASE07"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE07"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                if (PAROPERTASE08 != "")
                {
                    var valor8 = PAROPERTASE08.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE08",
                        valorProReg = Double.Parse(valor8),
                        minimoParametro = buscarMin("PAROPERTASE08") - 0.000000011920929,
                        maximoParametro = buscarMax("PAROPERTASE08"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE08"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE08",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE08") - 0.000000011920929,
                        maximoParametro = buscarMax("PAROPERTASE08"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE08"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                if (PAROPERTASE09 != "")
                {
                    var valor9 = PAROPERTASE09.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE09",
                        valorProReg = Double.Parse(valor9),
                        minimoParametro = buscarMin("PAROPERTASE09") - 0.000000011920929,
                        maximoParametro = buscarMax("PAROPERTASE09"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE09"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE09",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE09") - 0.000000011920929,
                        maximoParametro = buscarMax("PAROPERTASE09"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE09"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                if (PAROPERTASE10 != "")
                {
                    var valor10 = PAROPERTASE10.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE10",
                        valorProReg = Double.Parse(valor10),
                        minimoParametro = buscarMin("PAROPERTASE10") + 0.00000004768372,
                        maximoParametro = buscarMax("PAROPERTASE10") - 0.00000004768372,
                        nombreUnidadMedida = buscarMed("PAROPERTASE10"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE10",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE10") + 0.00000004768372,
                        maximoParametro = buscarMax("PAROPERTASE10") - 0.00000004768372,
                        nombreUnidadMedida = buscarMed("PAROPERTASE10"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }

                if (PAROPERTASE11 != "")
                {
                    var valor11 = PAROPERTASE11.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE11",
                        valorProReg = Double.Parse(valor11),
                        minimoParametro = buscarMin("PAROPERTASE11") - 0.000000011920929,
                        maximoParametro = buscarMax("PAROPERTASE11") - 0.00000004768372,
                        nombreUnidadMedida = buscarMed("PAROPERTASE11"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE11",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE11") - 0.000000011920929,
                        maximoParametro = buscarMax("PAROPERTASE11") - 0.00000004768372,
                        nombreUnidadMedida = buscarMed("PAROPERTASE11"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                if (PAROPERTASE12 != "")
                {
                    var valor12 = PAROPERTASE12.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE12",
                        valorProReg = Double.Parse(valor12),
                        minimoParametro = buscarMin("PAROPERTASE12"),
                        maximoParametro = buscarMax("PAROPERTASE12") - 0.00000009536743,
                        nombreUnidadMedida = buscarMed("PAROPERTASE12"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE12",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE12") ,
                        maximoParametro = buscarMax("PAROPERTASE12") - 0.00000009536743,
                        nombreUnidadMedida = buscarMed("PAROPERTASE12"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }

                if (PAROPERTASE13 != "")
                {
                    var valor13 = PAROPERTASE13.Replace(".", ",");
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE13",
                        valorProReg = Double.Parse(valor13),
                        minimoParametro = buscarMin("PAROPERTASE13"),
                        maximoParametro = buscarMax("PAROPERTASE13"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE13"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                else
                {
                    Ase = new ProRegOprTanASE
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERTASE13",
                        valorProReg = null,
                        minimoParametro = buscarMin("PAROPERTASE13"),
                        maximoParametro = buscarMax("PAROPERTASE13"),
                        nombreUnidadMedida = buscarMed("PAROPERTASE13"),
                        fechaCreaProReg = DateTime.Now
                    };
                    db.ProRegOprTanASE.Add(Ase);
                }
                db.SaveChanges();
                ViewBag.codEquipo = codEquipo;
                ViewBag.fecha = fecha;
                ViewBag.estado = estado;
                return RedirectToAction("ListaForms", new { codEquipo = codEquipo, codRegistro = codRegistro, fecha = fecha, estado = estado });

            }
            catch (DbEntityValidationException ex)
            {
                foreach (var validationErrors in ex.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        System.Diagnostics.Debug.WriteLine("Property: " + validationError.PropertyName + " Error: " + validationError.ErrorMessage);
                    }
                }
                return RedirectToAction("ListaForms", new { codEquipo = codEquipo, codRegistro = codRegistro, fecha = fecha, estado = estado });
            }
        }


        /////////////////////////////////////////////////////////////////////EDITAR//////////////////////////////

        public ActionResult Edit(TimeSpan? hora, string codEquipo, DateTime? fecha, int codRegistro)
        {
            ViewBag.codEquipo = codEquipo;
            if (hora == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CargarDatosUsuario();
            // Obtener una lista de todos los registros que tengan el mismo codRegistroFormulario
            var proRegOprTanASEList = db.ProRegOprTanASE.Where(r => r.horaTrabajoProReg == hora).Where(p => p.codRegistroFormulario == codRegistro).ToList();

            if (proRegOprTanASEList == null || proRegOprTanASEList.Count == 0)
            {
                return HttpNotFound();
            }
            ViewBag.codRegistro = codRegistro;
            ViewBag.codEstado = "Creado";
            ViewBag.hora = hora;
            ViewBag.fecha = fecha;
            ViewBag.codUsuarioCrea = new SelectList(db.AdmUsuario, "codUsuario", "contraseña", proRegOprTanASEList[0].codUsuarioCrea);
            // Pasar la lista  de registros como modelo a la vista
            return View(proRegOprTanASEList);
        }

        public ActionResult UpdateProRegOprTanASE(List<ProRegOprTanASE> modelList, TimeSpan? hora, string codEquipo, DateTime? fecha, int codRegistro) 
        { 
            var user = (AdmUsuario)Session["User"];
            ViewBag.codEquipo = codEquipo;
            CargarDatosUsuario();
            if (modelList == null)
            {
                throw new ArgumentNullException(nameof(modelList));
            }

            using (var context = new SistemaEntities())
            {
                foreach (var item in modelList)
                {

                    var proRegOprTanASE = context.ProRegOprTanASE.Find(item.codRegistro);
                    proRegOprTanASE.valorProReg = item.valorProReg;
                    proRegOprTanASE.fechaModProReg = DateTime.Now;
                    proRegOprTanASE.codUsuarioMod = user.codUsuario;
                    context.Entry(proRegOprTanASE).State = EntityState.Modified;
                }

                context.SaveChanges();
            }

            return RedirectToAction("Index", new { codEquipo = codEquipo, codEstado = "Creado", hour = hora, fecha = fecha, codRegistro = codRegistro });
        }

        ////////////////////////////////////////////Eliminar//////////////////////
        public ActionResult DeleteConfirmedASE(TimeSpan? hora, string codEquipo, DateTime? fecha, int? codRegistro, string estado, DateTime? fecha2)
        {
            ViewBag.codRegistro = codRegistro;
            ViewBag.codEquipo = codEquipo;
            ViewBag.hora = hora;
            ViewBag.fecha = fecha;
            ViewBag.estado = estado;
            ViewBag.fecha2 = fecha2;
            using (var context = new SistemaEntities())
            {
                var registrosAEliminar = context.ProRegOprTanASE.Where(r => r.fechaTrabajoProReg == fecha && r.codRegistroFormulario == codRegistro && r.horaTrabajoProReg == hora).ToList();

                context.ProRegOprTanASE.RemoveRange(registrosAEliminar);
                context.SaveChanges();
            }


            // Redirigir a la vista ListarForms
            return RedirectToAction("ListaForms", new { codEquipo = codEquipo, codRegistro = codRegistro, fecha = fecha, estado = estado });
        }


        public ActionResult DeleteConfirmedForm(int id, string codEquipo, DateTime? fecha )
        {
            CargarDatosUsuario();
            ViewBag.codEquipo = codEquipo;
            ViewBag.FechaSeleccionada = fecha;
            ProAdmForm proAdmForm = db.ProAdmForm.Find(id);
            db.ProAdmForm.Remove(proAdmForm);
            db.SaveChanges();
            return RedirectToAction("Registros", new { codEquipo = codEquipo ,fecha = fecha });
        }

        ////////////////////////////////////////////Fin//////////////////////
        public ActionResult Finalizar(int id, string codEquipo, DateTime? fecha)
        {
            var user = (AdmUsuario)Session["User"];
            CargarDatosUsuario();
            using (var context = new SistemaEntities())
            {

                TimeSpan horaAccion;
                DateTime now = DateTime.Now;
                horaAccion = new TimeSpan(now.Hour, now.Minute, now.Second);
                var proAcciones = new AdmProgAccionesFormulario();
                proAcciones = new AdmProgAccionesFormulario
                {
                    codRegistroFormulario = id,
                    creadoPor = user.codUsuario,
                    Accion = "Finalizado",
                    fechaAccion = DateTime.Now,
                    horaActual = horaAccion,
                    //codEmpresa = user.codEmpresa,
                };
                db.AdmProgAccionesFormulario.Add(proAcciones);
                db.SaveChanges();

                var proAdmForm = context.ProAdmForm.FirstOrDefault(p => p.codRegistro == id);

                if (proAdmForm != null)
                {
                    proAdmForm.codEstado = "est1";
                    context.SaveChanges();
                }
            }
            ViewBag.FechaSeleccionada = fecha;
            return RedirectToAction("Registros", new { codEquipo = codEquipo , fecha = fecha });
        }


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        ////////////////////////**************METODOS**********************************////////////////////


        public string buscarMed(string id)
        {
            using (SistemaEntities svcContext = new SistemaEntities())
            {
                var med = (from c in svcContext.ProParametro
                           where c.codParametro == id
                           select c.codUnidadMedida).FirstOrDefault();
                return med;
            }
        }
        public float? buscarMax(string id)
        {
            using (SistemaEntities svcContext = new SistemaEntities())
            {
                var max = (from c in svcContext.ProParametro
                           where c.codParametro == id
                           select c.maximoParametro).FirstOrDefault();
                return (float?)max;
            }
        }
        public float? buscarMin(string id)
        {
            using (SistemaEntities s = new SistemaEntities())
            {
                var min = (from c in s.ProParametro
                           where c.codParametro == id
                           select c.minimoParametro).FirstOrDefault();
                return (float?)min;
            }
        }

    }
}
