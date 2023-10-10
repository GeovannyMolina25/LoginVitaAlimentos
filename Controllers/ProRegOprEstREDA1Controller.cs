using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Validation;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls.WebParts;
using Crud2.Models;


namespace Crud2.Controllers
{
    public class ProRegOprEstREDA1Controller : Controller
    {

        private readonly SistemaEntities db = new SistemaEntities();

        // GET: ProRegOprEstREDA1


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
            var proAdmForm = db.ProAdmForm.Include(p => p.AdmEstado).Include(p => p.AdmFormulario).Include(p => p.PQPRODMAQUINA);
         /*   RCAJAS 
              var data = proAdmForm
               .Where(p => p.codEquipo == codEquipo);
         */
            CargarDatosUsuario();
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
                        codFormulario = "PRO-RE039",
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








        public ActionResult Index(TimeSpan? hour, string codEstado,string codEquipo, DateTime? fecha, int codRegistro)
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

            var proRegOprEstREDA1 = db.ProRegOprEstREDA1
                .Include(p => p.AdmUsuario)
                .Include(p => p.ProAdmForm)
                .Include(p => p.ProParametro)
                .Include(p => p.ProAdmForm.AdmEstado)
                .Where(p => p.horaTrabajoProReg == hour)
                .Where(p => p.codRegistroFormulario == codRegistro);

            return View(proRegOprEstREDA1.ToList());
        }

        
        public ActionResult ListaForms(DateTime? fecha, string codEquipo, int codRegistro, string estado)
        {
            CargarDatosUsuario();
            ViewBag.fecha = fecha;
            var proRegOprEstREDA1 = db.ProRegOprEstREDA1
                .Include(p => p.AdmUsuario)
                .Include(p => p.ProAdmForm)
                .Include(p => p.ProParametro)
                .Include(p => p.ProAdmForm.AdmEstado)
                .Include(p => p.ProAdmForm)
                .Where(p => p.ProAdmForm.codEquipo == codEquipo)
                .Where(p => p.fechaTrabajoProReg== fecha)
                .Where(p => p.codRegistroFormulario == codRegistro)
                .OrderByDescending(p => p.horaTrabajoProReg)
                .ToList();                
            ViewBag.codEquipo = codEquipo;
            ViewBag.codRegistro = codRegistro;
            ViewBag.estado = estado;
            return View(proRegOprEstREDA1);
        }



        ////////////////////////////////////////////////////////////////CREAR/////////////////////////////////////////////////
        
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
        public ActionResult Create(DateTime fecha, string codEquipo, TimeSpan hora, int codRegistro,string estado , string PAROPERREDA01 = null, string PAROPERREDA02 = null, string PAROPERREDA03 = null, string PAROPERREDA04 = null,
            string PAROPERREDA05 = null, string PAROPERREDA06 = null, string PAROPERREDA07 = null, string PAROPERREDA08 = null, string PAROPERREDA09 = null, string PAROPERREDA10 = null, string PAROPERREDA11 = null, 
            string PAROPERREDA12 = null, string PAROPERREDA13 = null, string PAROPERREDA14 = null, string PAROPERREDA15 = null, string PAROPERREDA16 = null, string PAROPERREDA17 = null)
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

                  var proRegOprEstREDA1 = new ProRegOprEstREDA1();
                  if (PAROPERREDA01 != "")
                  {
                      var valor = PAROPERREDA01.Replace(".", ",");


                          proRegOprEstREDA1 = new ProRegOprEstREDA1
                          {
                              codUsuarioCrea = user.codUsuario,
                              codSitio = user.codSitio,
                              codEmpresa = user.codEmpresa,
                              fechaTrabajoProReg = fecha,
                              horaTrabajoProReg = hora,
                              codRegistroFormulario = codRegistroFormulario,
                              codParametro = "PAROPERREDA01",
                              valorProReg = Double.Parse(valor),
                              minimoParametro = BuscarMin("PAROPERREDA01"),
                              maximoParametro = BuscarMax("PAROPERREDA01"),
                              nombreUnidadMedida = BuscarMed("PAROPERREDA01"),
                              fechaCreaProReg = DateTime.Now
                          };
                          db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);

                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA01",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA01"),
                          maximoParametro = BuscarMax("PAROPERREDA01"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA01"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }

                  if (PAROPERREDA02 != "")
                  {
                      var valor2 = PAROPERREDA02.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA02",
                          valorProReg = Double.Parse(valor2),
                          minimoParametro = BuscarMin("PAROPERREDA02"),
                          maximoParametro = BuscarMax("PAROPERREDA02"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA02"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA02",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA02"),
                          maximoParametro = BuscarMax("PAROPERREDA02"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA02"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ///////////////////////3//////////////////////
                  if (PAROPERREDA03 != "")
                  {
                      var valor3 = PAROPERREDA03.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA03",
                          valorProReg = Double.Parse(valor3),
                          minimoParametro = BuscarMin("PAROPERREDA03"),
                          maximoParametro = BuscarMax("PAROPERREDA03"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA03"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA03",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA03"),
                          maximoParametro = BuscarMax("PAROPERREDA03"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA03"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ////////////////////////4//////////////////////
                  if (PAROPERREDA04 != "")
                  {
                      var valor4 = PAROPERREDA04.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA04",
                          valorProReg = Double.Parse(valor4),
                          minimoParametro = BuscarMin("PAROPERREDA04"),
                          maximoParametro = BuscarMax("PAROPERREDA04"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA04"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA04",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA04"),
                          maximoParametro = BuscarMax("PAROPERREDA04"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA04"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  /////////////////////5/////////////////
                  if (PAROPERREDA05 != "")
                  {
                      var valor5 = PAROPERREDA05.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA05",
                          valorProReg = Double.Parse(valor5),
                          minimoParametro = BuscarMin("PAROPERREDA05"),
                          maximoParametro = BuscarMax("PAROPERREDA05"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA05"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA05",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA05"),
                          maximoParametro = BuscarMax("PAROPERREDA05"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA05"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ////////////////6//////////////////
                  if (PAROPERREDA06 != "")
                  {
                      var valor6 = PAROPERREDA06.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA06",
                          valorProReg = Double.Parse(valor6),
                          minimoParametro = BuscarMin("PAROPERREDA06"),
                          maximoParametro = BuscarMax("PAROPERREDA06"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA06"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA06",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA06"),
                          maximoParametro = BuscarMax("PAROPERREDA06"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA06"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ////////////////////7//////////////////////////
                  if (PAROPERREDA07 != "")
                  {
                      var valor7 = PAROPERREDA07.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA07",
                          valorProReg = Double.Parse(valor7),
                          minimoParametro = BuscarMin("PAROPERREDA07"),
                          maximoParametro = BuscarMax("PAROPERREDA07"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA07"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA07",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA07"),
                          maximoParametro = BuscarMax("PAROPERREDA07"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA07"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  /////////////////////8//////////////////////////////
                  if (PAROPERREDA08 != "")
                  {
                      var valor8 = PAROPERREDA08.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA08",
                          valorProReg = Double.Parse(valor8),
                          minimoParametro = BuscarMin("PAROPERREDA08"),
                          maximoParametro = BuscarMax("PAROPERREDA08"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA08"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA08",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA08"),
                          maximoParametro = BuscarMax("PAROPERREDA08"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA08"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ///////////////9//////////////////
                  if (PAROPERREDA09 != "")
                  {
                      var valor9 = PAROPERREDA09.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA09",
                          valorProReg = Double.Parse(valor9),
                          minimoParametro = BuscarMin("PAROPERREDA09"),
                          maximoParametro = BuscarMax("PAROPERREDA09"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA09"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA09",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA09"),
                          maximoParametro = BuscarMax("PAROPERREDA09"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA09"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ////////////////////10/////////////////
                  if (PAROPERREDA10 != "")
                  {
                      var valor10 = PAROPERREDA10.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA10",
                          valorProReg = Double.Parse(valor10),
                          minimoParametro = BuscarMin("PAROPERREDA10"),
                          maximoParametro = BuscarMax("PAROPERREDA10"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA10"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA10",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA10"),
                          maximoParametro = BuscarMax("PAROPERREDA10"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA10"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ////////////11//////////////
                  if (PAROPERREDA11 != "")
                  {
                      var valor11 = PAROPERREDA11.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA11",
                          valorProReg = Double.Parse(valor11),
                          minimoParametro = BuscarMin("PAROPERREDA11"),
                          maximoParametro = BuscarMax("PAROPERREDA11"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA11"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA11",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA11"),
                          maximoParametro = BuscarMax("PAROPERREDA11"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA11"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ///////////////////////12///////////////////////
                  if (PAROPERREDA12 != "")
                  {
                      var valor12 = PAROPERREDA12.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA12",
                          valorProReg = Double.Parse(valor12),
                          minimoParametro = BuscarMin("PAROPERREDA12"),
                          maximoParametro = BuscarMax("PAROPERREDA12"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA12"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA12",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA12"),
                          maximoParametro = BuscarMax("PAROPERREDA12"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA12"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ///////////////////13///////////////
                  if (PAROPERREDA13 != "")
                  {
                      var valor13 = PAROPERREDA13.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA13",
                          valorProReg = Double.Parse(valor13),
                          minimoParametro = BuscarMin("PAROPERREDA13"),
                          maximoParametro = BuscarMax("PAROPERREDA13"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA13"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA13",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA13"),
                          maximoParametro = BuscarMax("PAROPERREDA13"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA13"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  //////////////////////14///////////////////////
                  if (PAROPERREDA14 != "")
                  {
                      var valor14 = PAROPERREDA14.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA14",
                          valorProReg = Double.Parse(valor14),
                          minimoParametro = BuscarMin("PAROPERREDA14"),
                          maximoParametro = BuscarMax("PAROPERREDA14"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA14"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA14",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA14"),
                          maximoParametro = BuscarMax("PAROPERREDA14"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA14"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  //////////////15////////////////
                  if (PAROPERREDA15 != "")
                  {
                      var valor15 = PAROPERREDA15.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA15",
                          valorProReg = Double.Parse(valor15),
                          minimoParametro = BuscarMin("PAROPERREDA15"),
                          maximoParametro = BuscarMax("PAROPERREDA15"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA15"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA15",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA15"),
                          maximoParametro = BuscarMax("PAROPERREDA15"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA15"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  ///////////////////16////////////////
                  if (PAROPERREDA16 != "")
                  {
                      var valor16 = PAROPERREDA16.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA16",
                          valorProReg = Double.Parse(valor16),
                          minimoParametro = BuscarMin("PAROPERREDA16"),
                          maximoParametro = BuscarMax("PAROPERREDA16") - 0.00000009536743,
                          nombreUnidadMedida = BuscarMed("PAROPERREDA16"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                    proRegOprEstREDA1 = new ProRegOprEstREDA1
                    {
                        codUsuarioCrea = user.codUsuario,
                        codSitio = user.codSitio,
                        codEmpresa = user.codEmpresa,
                        fechaTrabajoProReg = fecha,
                        horaTrabajoProReg = hora,
                        codRegistroFormulario = codRegistroFormulario,
                        codParametro = "PAROPERREDA16",
                        valorProReg = null,
                        minimoParametro = BuscarMin("PAROPERREDA16"),
                        maximoParametro = BuscarMax("PAROPERREDA16") - 0.00000009536743,
                          nombreUnidadMedida = BuscarMed("PAROPERREDA16"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  /////////////////17/////////////////////
                  if (PAROPERREDA17 != "")
                  {
                      var valor17 = PAROPERREDA17.Replace(".", ",");
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA17",
                          valorProReg = Double.Parse(valor17),
                          minimoParametro = BuscarMin("PAROPERREDA17"),
                          maximoParametro = BuscarMax("PAROPERREDA17"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA17"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
                  }
                  else
                  {
                      proRegOprEstREDA1 = new ProRegOprEstREDA1
                      {
                          codUsuarioCrea = user.codUsuario,
                          codSitio = user.codSitio,
                          codEmpresa = user.codEmpresa,
                          fechaTrabajoProReg = fecha,
                          horaTrabajoProReg = hora,
                          codRegistroFormulario = codRegistroFormulario,
                          codParametro = "PAROPERREDA17",
                          valorProReg = null,
                          minimoParametro = BuscarMin("PAROPERREDA17"),
                          maximoParametro = BuscarMax("PAROPERREDA17"),
                          nombreUnidadMedida = BuscarMed("PAROPERREDA17"),
                          fechaCreaProReg = DateTime.Now
                      };
                      db.ProRegOprEstREDA1.Add(proRegOprEstREDA1);
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
                  return RedirectToAction("ListaForms", new { id = codEquipo, codRegistro = codRegistro, fecha = fecha, estado = estado });
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
            var proRegOprEstREDA1List = db.ProRegOprEstREDA1.Where(r => r.horaTrabajoProReg == hora).Where(p => p.codRegistroFormulario == codRegistro).ToList();

            if (proRegOprEstREDA1List == null || proRegOprEstREDA1List.Count == 0)
            {
                return HttpNotFound();
            }
            ViewBag.codRegistro = codRegistro;
            ViewBag.codEstado = "Creado";
            ViewBag.hora = hora;
            ViewBag.fecha = fecha;
            ViewBag.codUsuarioCrea = new SelectList(db.AdmUsuario, "codUsuario", "contraseña", proRegOprEstREDA1List[0].codUsuarioCrea);
            // Pasar la lista  de registros como modelo a la vista
            return View(proRegOprEstREDA1List);
        }
        public ActionResult UpdateProRegOprEstREDA1(List<ProRegOprEstREDA1> modelList, TimeSpan? hora, string codEquipo, DateTime? fecha, int codRegistro)
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

                    var proRegOprEstREDA1 = context.ProRegOprEstREDA1.Find(item.codRegistro);
                    proRegOprEstREDA1.valorProReg = item.valorProReg;
                    proRegOprEstREDA1.fechaModProReg = DateTime.Now;
                    proRegOprEstREDA1.codUsuarioMod = user.codUsuario;
                    context.Entry(proRegOprEstREDA1).State = EntityState.Modified;
                }

                context.SaveChanges();
            }

            return RedirectToAction("Index", new { codEquipo = codEquipo, codEstado = "Creado", hour = hora, fecha = fecha, codRegistro = codRegistro });
        }
        ////////////////////////////////////////////Eliminar//////////////////////
        public ActionResult DeleteConfirmedREDA(TimeSpan? hora, string codEquipo, DateTime? fecha, int? codRegistro, string estado)
        {
            ViewBag.codRegistro = codRegistro;
            ViewBag.codEquipo = codEquipo;
            ViewBag.hora = hora;
            ViewBag.fecha = fecha;
            ViewBag.estado = estado;
            using (var context = new SistemaEntities())
            {
                var registrosAEliminar = context.ProRegOprEstREDA1.Where(r => r.fechaTrabajoProReg == fecha && r.codRegistroFormulario == codRegistro && r.horaTrabajoProReg == hora).ToList();

                context.ProRegOprEstREDA1.RemoveRange(registrosAEliminar);
                context.SaveChanges();
            }


            // Redirigir a la vista ListarForms
            return RedirectToAction("ListaForms", new { codEquipo = codEquipo, codRegistro = codRegistro, fecha = fecha, estado = estado  });
        }

        public ActionResult DeleteConfirmedForm(int id, string codEquipo, DateTime? fecha)
        {
            CargarDatosUsuario();
            ViewBag.codEquipo = codEquipo;
            ViewBag.FechaSeleccionada = fecha;
            ProAdmForm proAdmForm = db.ProAdmForm.Find(id);
            db.ProAdmForm.Remove(proAdmForm);
            db.SaveChanges();
            return RedirectToAction("Registros", new { codEquipo = codEquipo , fecha = fecha});
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
            ViewBag.FechaSeleccionada= fecha;
            return RedirectToAction("Registros", new { codEquipo = codEquipo, fecha = fecha});
        }
       

        // POST: ProRegOprEstREDA1/Delete/5


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }



        ////////////////////////**************METODOS**********************************////////////////////
        
        
        public string BuscarMed(string id)
        {
            using (SistemaEntities svcContext = new SistemaEntities())
            {
                var med = (from c in svcContext.ProParametro
                           where c.codParametro == id
                           select c.codUnidadMedida).FirstOrDefault();
                return med;
            }
        }
        public float? BuscarMax(string id)
        {
            using (SistemaEntities svcContext = new SistemaEntities())
            {
                var max = (from c in svcContext.ProParametro
                           where c.codParametro == id
                           select c.maximoParametro).FirstOrDefault();
                return (float?)max;
            }
        }
        public float? BuscarMin(string id)
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
