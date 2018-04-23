/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.beans;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Wissem
 */
@Entity
@Table(name = "compte")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Compte.findAll", query = "SELECT c FROM Compte c order by c.idCompte desc")})
public class Compte implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Nom")
    private String nom;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Prenom")
    private String prenom;
    @Basic(optional = false)
    @NotNull
    @Column(name = "DateDeNaissance")
    @Temporal(TemporalType.DATE)
    private Date dateDeNaissance;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 8)
    @Column(name = "IdCompte")
    private String idCompte;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Ville")
    private String ville;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "PhotoDeProfil")
    private String photoDeProfil = "avatar.png";
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "MotDePasse")
    private String motDePasse;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 25)
    @Column(name = "Type")
    private String type = "Utilisateur";
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Ville-interet")
    private String villeinteret = "";
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "Catégorie-interet")
    private String categorieinteret = "";
    @JoinTable(name = "signalisation", joinColumns = {
        @JoinColumn(name = "compte", referencedColumnName = "IdCompte")}, inverseJoinColumns = {
        @JoinColumn(name = "publication", referencedColumnName = "IdPublication")})
    @ManyToMany(fetch = FetchType.EAGER)
    private List<Publication> publicationsSignales;

    public Compte() {
    }

    public Compte(String idCompte) {
        this.idCompte = idCompte;
    }

    public Compte(String idCompte, String nom, String prenom, Date dateDeNaissance, String ville, String photoDeProfil, String motDePasse, String type, String villeinteret, String categorieinteret) {
        this.idCompte = idCompte;
        this.nom = nom;
        this.prenom = prenom;
        this.dateDeNaissance = dateDeNaissance;
        this.ville = ville;
        this.photoDeProfil = photoDeProfil;
        this.motDePasse = motDePasse;
        this.type = type;
        this.villeinteret = villeinteret;
        this.categorieinteret = categorieinteret;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getDateDeNaissance() {
        String dn = new SimpleDateFormat("dd-MM-yyyy").format(dateDeNaissance);
        return dn;
    }

    public void setDateDeNaissance(Date dateDeNaissance) {
        this.dateDeNaissance = dateDeNaissance;
    }

    public String getIdCompte() {
        return idCompte;
    }

    public void setIdCompte(String idCompte) {
        this.idCompte = idCompte;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPhotoDeProfil() {
        return photoDeProfil;
    }

    public void setPhotoDeProfil(String photoDeProfil) {
        this.photoDeProfil = photoDeProfil;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getVilleinteret() {
        return villeinteret;
    }

    public void setVilleinteret(String villeinteret) {
        this.villeinteret = villeinteret;
    }

    public String getCategorieinteret() {
        return categorieinteret;
    }

    public void setCategorieinteret(String categorieinteret) {
        this.categorieinteret = categorieinteret;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCompte != null ? idCompte.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Compte)) {
            return false;
        }
        Compte other = (Compte) object;
        if ((this.idCompte == null && other.idCompte != null) || (this.idCompte != null && !this.idCompte.equals(other.idCompte))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.beans.Compte[ idCompte=" + idCompte + " ]";
    }

    @XmlTransient
    public List<Publication> getPublicationsSignales() {
        return publicationsSignales;
    }

    public void setPublicationsSignales(List<Publication> publicationsSignales) {
        this.publicationsSignales = publicationsSignales;
    }

    public void SignalerPublication(Publication publication) {
        this.publicationsSignales.add(publication);
    }

    public boolean DejaSignaler(Publication publication) {
        return publicationsSignales.contains(publication);
    }
}
