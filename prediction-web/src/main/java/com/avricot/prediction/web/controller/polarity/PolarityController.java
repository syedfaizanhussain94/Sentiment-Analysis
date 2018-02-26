package com.avricot.prediction.web.controller.polarity;

import java.util.List;

import javax.inject.Inject;

import org.bson.types.ObjectId;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.avricot.prediction.model.candidat.Candidat;
import com.avricot.prediction.model.candidat.Candidat.CandidatName;
import com.avricot.prediction.model.tweet.Tweet;
import com.avricot.prediction.report.Polarity;
import com.avricot.prediction.repository.candidat.CandidatRespository;
import com.avricot.prediction.repository.tweet.TweetRepository;

@Controller
@RequestMapping("/")
public class PolarityController {

	@Inject
	private TweetRepository tweetRepository;
	@Inject
	private CandidatRespository candidatRespository;

	@RequestMapping(method = RequestMethod.GET)
	public String home() {
		return "home";
	}

	@ResponseBody
	@RequestMapping(value = "polarity", method = RequestMethod.GET)
	public Tweet getRandomTweet() {

		List<Tweet> findByChecked = tweetRepository.getTweetNotChecked(20);

		int i = (int) (Math.random() * 20L);
		return findByChecked.get(i);
	}

	@ResponseBody
	@RequestMapping(value = "addPolarity", method = RequestMethod.POST)
	public void addPolarity(final String tweetId, final String val) {
		Tweet findOne = tweetRepository.findOne(new ObjectId(tweetId));

		Polarity p = null;

		if (val.equals("positive")) {
			p = Polarity.POSITIVE;
		} else if (val.equals("negative")) {
			p = Polarity.NEGATIVE;
		} else if (val.equals("neutral")) {
			p = Polarity.NEUTRAL;
		} else if (val.equals("invalid")) {
			p = Polarity.INVALID;
		} else if (val.equals("not_french")) {
			p = Polarity.NOT_FRENCH;
		}

		// findOne.setChecked(true);
		// findOne.setPolarity(p);
		// tweetRepository.save(findOne);

		updateTweets(p, findOne.getValue(), findOne.getCandidatName());
	}

	private void updateTweets(Polarity polarity, String value, CandidatName candidat) {
		List<Tweet> findByValueAndCandidatId = tweetRepository.findByValueAndCandidatName(value, candidat);
		for (Tweet t : findByValueAndCandidatId) {
			t.setChecked(true);
			t.setPolarity(polarity);
			tweetRepository.save(t);
		}
	}
}
