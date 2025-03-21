
const SimpleReview = require('../models/Rating');
const Product = require('../models/Product');

async function  getRateAVG (prodid){
  sum=0
    const simpleReviews = await SimpleReview.find({ product: prodid });
    arr = Array.from(simpleReviews);
  //  console.log(arr)
    arr.forEach(element => { 
      sum+=parseInt(element['rating']) 
    }); 
    return arr.length >0 ? (sum/arr.length).toFixed(1) : "0.0";
}

exports.createSimpleReview = async (req, res) => {
  try {
    const { user, product, rating } = req.body;

    const newSimpleReview = new SimpleReview({
      user,
      product,
      rating,
    });
    await newSimpleReview.save();
    await Product.findByIdAndUpdate(product, {rate:await getRateAVG(product) })
    res.status(201).json({ message: 'Avis simple créé avec succès', review: newSimpleReview });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la création de l\'avis simple', error: error.message });
  }
};

exports.getAllSimpleReviews = async (req, res) => {
try{
  const  {productId}  = req.params;
    const simpleReviews = await SimpleReview.find({ product: productId });
    arr = Array.from(simpleReviews)
     oneStar=0;twoStars=0;threeStars=0;fourStars=0;fiveStars=0;sum=0;
    arr.forEach(element=>{
      sum+=element.rating;
      if(element.rating==1){
        oneStar++
      }else if(element.rating==2){
        twoStars++
      }else if(element.rating==3){
        threeStars++
      }else if(element.rating==4){
        fourStars++
      }else if(element.rating==5){
        fiveStars++
      }
    })
   const prod =await Product.findById(productId);
   avg = prod.rate
  
    res.status(200).json({oneStar:oneStar,twoStars:twoStars,threeStars:threeStars,fourStars:fourStars,fiveStars:fiveStars,simpleReviews,number:arr.length,avg:avg});
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération des avis simples', error: error.message });
  }
};

exports.getSimpleReviewById = async (req, res) => {
  try {
    const simpleReview = await SimpleReview.findById(req.params.id);
    if (!simpleReview) {
      return res.status(404).json({ error: 'Avis simple non trouvé.' });
    }
    res.status(200).json(simpleReview);
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération de l\'avis simple', error: error.message });
  }
};

exports.updateSimpleReview = async (req, res) => {
  try {
    const simpleReview = await SimpleReview.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!simpleReview) {
      return res.status(404).json({ error: 'Avis simple non trouvé.' });
    }
    await Product.findByIdAndUpdate(simpleReview.product, {rate:await getRateAVG(simpleReview.product) })
    res.status(200).json(simpleReview);
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la mise à jour de l\'avis simple', error: error.message });
  }
};

exports.deleteSimpleReview = async (req, res) => {
  try {
    const simpleReview = await SimpleReview.findByIdAndDelete(req.params.id);
    if (!simpleReview) {
      return res.status(404).json({ error: 'Avis simple non trouvé.' });
    }
    await Product.findByIdAndUpdate(simpleReview.product, {rate:await getRateAVG(simpleReview.product) })
    res.status(200).json({ message: 'Avis simple supprimé avec succès.' });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la suppression de l\'avis simple', error: error.message });
  }
};

exports.getSimpleReviewAverage = async (req,res)=>{
  try{
    sum=0
    const { productId } = req.params;
      const simpleReviews = await SimpleReview.find({ product: productId });
      arr = Array.from(simpleReviews);
    //  console.log(arr)
      arr.forEach(element => { 
        sum+=parseInt(element['rating']) 
      }); 
      res.status(200).json(arr.length >0 ? (sum/arr.length).toFixed(1) : "0.0");
    } catch (error) {
      res.status(500).json({ error: 'Erreur lors de la récupération des avis simples', error: error.message });
    }
};
