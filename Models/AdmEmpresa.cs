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
    
    public partial class AdmEmpresa
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public AdmEmpresa()
        {
            this.AdmSitio = new HashSet<AdmSitio>();
        }
    
        public int codRegistro { get; set; }
        public string codEmpresa { get; set; }
        public string nombreEmpresa { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AdmSitio> AdmSitio { get; set; }
    }
}
