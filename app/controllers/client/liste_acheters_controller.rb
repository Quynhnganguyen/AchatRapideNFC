class Client::ListeAchetersController < ApplicationController
  def index
    @client = client
    @listes= ListeAcheter.where(client_id: @client.id)
  end

  def new
    @client = client
    @favorie = @client.liste_acheter.new
    @favorie.save
  end
 
  def create
    @client = client
    @produit = produit
    @produit_exite = ListeAcheter.exists?(produit_id: @produit.id)
    
    if @produit_exite
      @message= "Produit existed"
    else
      @achat = @client.liste_acheter.create(client_id: @client.id, produit_id: @produit.id)
    @achat.save
      if @achat.save
         flash[:notice] =  "produit has been successfully added in liste favoris."
      else 
        flash[:notice] =  "erroooooo"
    end
  end
  end

 def destroy
    @client = client
    @produit = @client.liste_acheter.find(params[:id])
    @produit.destroy

    respond_to do |format|
      format.html { redirect_to client_liste_acheters_index_path }
      format.json { head :no_content }
    end
  end


private
  def liste_acheter_params
      params.require(:liste_acheter).permit(:client_id, :produit_id) if params[:liste_acheter]
  
  end

  def client
    if current_client.id
      id = current_client.id
      Client.find(current_client.id)
    end
  end

  def produit
    if params[:produit_id]
      id = params[:produit_id]
      Produit.find(params[:produit_id])
    end
  end
end
