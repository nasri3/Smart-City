/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.beans;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Wissem
 */
@Entity
@Table(name = "etablissement")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Etablissement.findAll", query = "SELECT e FROM Etablissement e")
    , @NamedQuery(name = "Etablissement.findByIdEtablissement", query = "SELECT e FROM Etablissement e WHERE e.idEtablissement = :idEtablissement")
    , @NamedQuery(name = "Etablissement.findByNom", query = "SELECT e FROM Etablissement e WHERE e.nom = :nom")
    , @NamedQuery(name = "Etablissement.findByVille", query = "SELECT e FROM Etablissement e WHERE e.ville = :ville")
    , @NamedQuery(name = "Etablissement.findByCat\u00e9gorie", query = "SELECT e FROM Etablissement e WHERE e.cat\u00e9gorie = :cat\u00e9gorie")})
public class Etablissement implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idEtablissement")
    private Integer idEtablissement;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Nom")
    private String nom;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Ville")
    private String ville;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Catégorie")
    private String categorie;
    @OneToMany(mappedBy = "etablissement")
    private List<Compte> compteList;

    public Etablissement() {
    }

    public Etablissement(Integer idEtablissement) {
        this.idEtablissement = idEtablissement;
    }

    public Etablissement(Integer idEtablissement, String nom, String ville, String categorie) {
        this.idEtablissement = idEtablissement;
        this.nom = nom;
        this.ville = ville;
        this.categorie = categorie;
    }

    public Integer getIdEtablissement() {
        return idEtablissement;
    }

    public void setIdEtablissement(Integer idEtablissement) {
        this.idEtablissement = idEtablissement;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    @XmlTransient
    public List<Compte> getCompteList() {
        return compteList;
    }

    public void setCompteList(List<Compte> compteList) {
        this.compteList = compteList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idEtablissement != null ? idEtablissement.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Etablissement)) {
            return false;
        }
        Etablissement other = (Etablissement) object;
        if ((this.idEtablissement == null && other.idEtablissement != null) || (this.idEtablissement != null && !this.idEtablissement.equals(other.idEtablissement))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.beans.Etablissement[ idEtablissement=" + idEtablissement + " ]";
    }
    
}
