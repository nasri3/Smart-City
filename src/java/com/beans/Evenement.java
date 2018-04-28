/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.beans;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Wissem
 */
@Entity
@Table(name = "evenement")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Evenement.findAll", query = "SELECT e FROM Evenement e")})

public class Evenement implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "IdEvenement")
    private Integer idEvenement;
    @Basic(optional = false)
    @NotNull
    @Column(name = "Date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date date;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "Titre")
    private String titre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 5000)
    @Column(name = "Texte")
    private String texte;
    @Size(max = 45)
    @Column(name = "Image")
    private String image;

    public Evenement() {
    }

    public Evenement(Integer idEvenement) {
        this.idEvenement = idEvenement;
    }

    public Evenement(Integer idEvenement, Date date, String titre, String texte) {
        this.idEvenement = idEvenement;
        this.date = date;
        this.titre = titre;
        this.texte = texte;
    }

    public Integer getIdEvenement() {
        return idEvenement;
    }

    public void setIdEvenement(Integer idEvenement) {
        this.idEvenement = idEvenement;
    }

    public String getDate() {
        String dc = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(date);
        return dc;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getTexte() {
        return texte;
    }

    public void setTexte(String texte) {
        this.texte = texte;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idEvenement != null ? idEvenement.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Evenement)) {
            return false;
        }
        Evenement other = (Evenement) object;
        if ((this.idEvenement == null && other.idEvenement != null) || (this.idEvenement != null && !this.idEvenement.equals(other.idEvenement))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.beans.Evenement[ idEvenement=" + idEvenement + " ]";
    }
    
}
