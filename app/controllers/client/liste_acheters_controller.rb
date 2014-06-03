class Client::ListeAchetersController < ApplicationController
	def index
		@client = client
		@listes= ListeAcheter.where(client_id: @client.id)
	end

  def new
    @client = client
    @achat = @client.liste_acheter.new
    @achat.save
  end
 
  def create
    @client = client
    @produit = produit
    @produit_existe = ListeAcheter.exists?(produit_id: @produit.id)

    if @produit_existe
      @message= "Produit existed"
    else
      @acheter = @client.liste_acheter.create(client_id: @client.id, produit_id: @produit.id)
      @acheter.save
      if @acheter.save
         flash[:notice] =  "produit has been successfully added in liste à acheter."
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
