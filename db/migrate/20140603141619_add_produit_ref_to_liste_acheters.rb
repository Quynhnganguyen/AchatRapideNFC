class AddProduitRefToListeAcheters < ActiveRecord::Migration
  def change
    add_reference :liste_acheters, :produit, index: true
  end

end
