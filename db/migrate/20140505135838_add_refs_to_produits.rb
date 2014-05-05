class AddRefsToProduits < ActiveRecord::Migration
  def change
    add_reference :produits, :source, index: true
    add_reference :produits, :type_de_produit, index: true
    add_reference :produits, :nfc, index: true
  end
end
