//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Crud2.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ProAdmForm
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ProAdmForm()
        {
            this.AdmProgAccionesFormulario = new HashSet<AdmProgAccionesFormulario>();
            this.ProRegOprEstREDA1 = new HashSet<ProRegOprEstREDA1>();
            this.ProRegOprTanASE = new HashSet<ProRegOprTanASE>();
        }
    
        public int codRegistro { get; set; }
        public string codFormulario { get; set; }
        public string codEstado { get; set; }
        public string aprobadoPor { get; set; }
        public Nullable<System.DateTime> fechaAprobacion { get; set; }
        public Nullable<System.TimeSpan> horaAprobacion { get; set; }
        public string codEquipo { get; set; }
        public string codEmpresa { get; set; }
        public Nullable<System.DateTime> fechaRegistro { get; set; }
        public string codUsuarioCrea { get; set; }
    
        public virtual AdmEstado AdmEstado { get; set; }
        public virtual AdmFormulario AdmFormulario { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AdmProgAccionesFormulario> AdmProgAccionesFormulario { get; set; }
        public virtual PQPRODMAQUINA PQPRODMAQUINA { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProRegOprEstREDA1> ProRegOprEstREDA1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ProRegOprTanASE> ProRegOprTanASE { get; set; }
    }
}
